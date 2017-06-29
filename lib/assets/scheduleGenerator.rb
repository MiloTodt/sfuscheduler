# Schedule Generator
# Takes in an array of courses in the form of 
# [
# ["Course Name", priority, ["Day", Start_Time, End_Time, location], ["Day", Start_Time, End_Time, location], ...[["CO", "Co-req name", ...], ["PRE", "Pre-req name", ...]],
# ["Course Name", priority, ["Day", Start_Time, End_Time, location], ["Day", Start_Time, End_Time, location], ...[["CO", "Co-req name", ...], ["PRE", "Pre-req name", ...]],
# ...
# ]
# computes all possible 1, 2, 3, 4, 5, 6 course schedules
# checks for time, location, pre-req conflicts
# checks to follow co-req constraints
# use getSchedule(number of courses per schedule, number of schedules, prioritize schedules(true or false))
# to get an array of course name indicating valid schedules

#=====================================================================
# CONSTANTS
#=====================================================================
MAX_COURSES_PER_SCHEDULE = 6
MAX_SCHEDULES_MADE = 38760	# 20 choose 6 assuming no conflicts

WEEK = ["M", "T", "W", "TH", "F", "S", "SU"]

HOURS = ["830", "930", "1030", "1130", "1230", "1330", "1430",
		"1530", "1630", "1730", "1830", "1930", "2030"]

TRANSIT_CONFLICT = [-1, 0, 1]

DAYS = {"M" => 0, "T" => 1, "W" => 2, 
	"TH" => 3, "F" => 4, "S" => 5, "SU" => 6}

CONVERT = {"DAY" => 0, "START"=>1, "END"=>2, "LOCATION"=>3}

START_TIMES = {"830" => 0, "930" => 1, "1030" => 2, "1130"=>3, "1230"=>4,
"1330"=>5, "1430"=>6, "1530"=>7, "1630"=>8, "1730"=>9, "1830"=>10, 
"1930"=>11, "2030"=>12}

END_TIMES = {"920" => 0, "1020" => 1, "1120" => 2, "1220"=>3, "1320"=>4,
"1420"=>5, "1520"=>6, "1620"=>7, "1720"=>8, "1820"=>9, "1920"=>10, 
"2020"=>11, "2120"=>12}

DEFAULT_SYM = '.'

#=====================================================================
# Day Class
#=====================================================================
class Day 
	def initialize(name)
		@name = name
		@hours = []
		HOURS.length.times do 
			@hours << DEFAULT_SYM
		end
	end

	def getName()
		@name
	end

	def getHour(hour)
		@hours[START_TIMES[hour]]
	end

	def setHours(start_t, end_t, symbol)
		# clone day incase it fails
		clone = []
		clone.replace(@hours)
		starting = START_TIMES[start_t]
		duration = END_TIMES[end_t] - starting
		if @hours[starting] == DEFAULT_SYM
			@hours[starting] = symbol
		else
			@hours.replace(clone)
			return false
		end
		starting += 1
		duration.times do |cur_hour|
			if @hours[cur_hour+starting] == DEFAULT_SYM
				@hours[cur_hour+starting] = symbol
			else
				@hours.replace(clone)
				return false
			end			
		end
		return true
	end

end

#=================================================================
# Week Class
#=================================================================
class Week
	def initialize()
		@days = []
		WEEK.length.times do |day|
			@days << Day.new(WEEK[day])
		end
		@courses = []
	end

	def getCourses()
		@courses
	end

	# check for time and location conflict
	def addCourse(course, symbol)
		# make clone in case of fail
		clone = []
		clone.replace(@days)
		tmp = course.getDates()
		tmp.length.times do |day|
			cur_day = tmp[day][CONVERT["DAY"]]
			start_t = tmp[day][CONVERT["START"]]
			end_t = tmp[day][CONVERT["END"]]
			if not @days[DAYS[cur_day]].setHours(start_t, end_t, symbol)
				@days.replace(clone)
				return false
			end
		end

		@courses <<course.getName
		return true
	end

# for debug purposes
	def printWeek()
		print "TIMES\t"
		WEEK.length.times do |day|
			print "#{@days[day].getName()}\t"
		end
		puts
		HOURS.length.times do |hour|
			cur_hour = HOURS[hour]
			print "#{cur_hour}\t"			
			if cur_hour == "830" or cur_hour == "930"
				print "\t"
			end
			WEEK.length.times do |day|
				cur_day = @days[day]
				print "#{cur_day.getHour(cur_hour)}\t"
			end
			puts
		end
	end


end


#=================================================================
# Course Class
#=================================================================
class Course
	def initialize(name, priority, dates, requisites) 
		@name = name
		@priority = priority
		@dates = []
		@conflicts = []
		@co_req = []
		@pre_req = []
		if dates.length > 0
			dates.each do |date|
				@dates << date
			end
		end
		if requisites.length > 0
			requisites.each do |requisite|
				if requisite[0] == "CO"
					(requisite.length-1).times do |co|
						@co_req << requisite[co+1]
					end
				elsif requisite[0] == "PRE"
					(requisite.length-1).times do |pre|
						@pre_req << requisite[pre+1]
					end
				end
			end
		end
	end

	def ==(course)
		if @name == course.getName 
			return true
		end
		return false
	end

	def getName
		@name
	end

	def getPriority
		@priority
	end

	def getDates
		@dates
	end

	def getConflicts
		@conflicts
	end 

	def getCoReq
		@co_req
	end

	# check if self has conflict location, time, or pre-requisite conflict with course
	def checkConflict(course)
		if  self.notDupe(course) and 
		( (self.checkLocationConflict(course) or self.checkTimeConflict(course)) or 
		@pre_req.include? course.getName[0...course.getName.length-5] ) 
			@conflicts << course
			course.checkConflict(self)	# if conflict exists, make sure that both self and conflicting course exists in each others conflicts
		end

	end

	# check if comparing with self or if already in conflicts
	def notDupe(course)
		if not self == course 
			if not self.inConflict(course)
				return true
			end
		end
		return false
	end

	# check if course is in @conflicts
	def inConflict(course)
		@conflicts.each do |conflict|
			if conflict == course or course.getName.include? conflict.getName 
				return true
			end
		end
		if self == course 
			return true
		end
		return false
	end
	
	def checkTimeConflict(course)
		check = Week.new()
		check.addCourse(self, 1)
		if not check.addCourse(course, 1)
			return true
		end
		return false
	end

	def checkLocationConflict(course)
		tmp = course.getDates
		@dates.length.times do |i|
			tmp.length.times do |j|
				# check if same day
				if @dates[i][CONVERT["DAY"]] == tmp[j][CONVERT["DAY"]]
					# check if different locations
					if @dates[i][CONVERT["LOCATION"]] != tmp[j][CONVERT["LOCATION"]]
						# check if courses occur in tandem
						if ((TRANSIT_CONFLICT.include? (START_TIMES[@dates[i][CONVERT["START"]]] - END_TIMES[tmp[j][CONVERT["END"]]] ) ) or
							(TRANSIT_CONFLICT.include? (END_TIMES[@dates[i][CONVERT["END"]]] - START_TIMES[tmp[j][CONVERT["START"]]] ) ) )
							if not self.inConflict(course)
								return true
							end
						end
					end
				end
			end
		end
		return false
	end

	# debug purposes
	def getConflictsNames
		ret = []
		if @conflicts.length > 0
			@conflicts.each do |conflict|
				ret << conflict.getName
			end
		end
		return ret
	end

	def printCourse
		puts "
Name:\t#{@name}
Priority:\t#{@priority}
Conflicts:\t#{@conflicts}
Dates:\t#{@dates}
Co-Req:\t#{@co_req}
Pre-Req:\t#{@pre_req}
		"
	end


end



#=================================================================
# Scheduler Class
#=================================================================
class Scheduler
	def initialize (courses)	# refer to scheduleGenerator_tester for an example on input
		@courses = []
		@num_courses = courses.length
		@oneCourse = []
		@twoCourses = []
		@threeCourses = []
		@fourCourses = []
		@fiveCourses = []
		@sixCourses = []
		@courseTable = {1 => @oneCourse, 2 => @twoCourses, 3=>@threeCourses, 4=>@fourCourses, 5=>@fiveCourses, 6=>@sixCourses}


		if @num_courses > 0
			courses.each do |course|
				@courses << Course.new(course[0], course[1], course[2], course[3])
			end
			self.compareConflicts
			self.generateSchedules
		end
	end

	def compareConflicts()
		@courses.each do |checking|
			@courses.each do |check_with|
				checking.checkConflict(check_with)
			end
		end
	end


	def generateSchedules
	# 6 nested loops through the whole course to make combinations of schedules
	# if there are no conflict between courses
	# then check if all co-reqs are met in all schedules
		if @num_courses > 0
			# do for 1 course
			@num_courses.times do |i|
				first = @courses[i]
				sum = first.getPriority
				@oneCourse << [sum, [first]]
				# Do for 2 course
				(@num_courses-i).times do |j|
					second = @courses[i+j]
					if not (first.inConflict(second))
						sum = first.getPriority + second.getPriority 
						@twoCourses << [sum, [first, second]]
						# do for 3 courses
						(@num_courses-i-j).times do |k|
							third = @courses[i+j+k]
							if not (first.inConflict(third) or second.inConflict(third) )
								sum = first.getPriority + second.getPriority + third.getPriority
								@threeCourses << [sum, [first, second, third]]
								# do for 4 courses
								(@num_courses-i-j-k).times do |l|
									fourth = @courses[i+j+k+l]
									if not (first.inConflict(fourth) or 
									second.inConflict(fourth) or third.inConflict(fourth))
										sum = first.getPriority + second.getPriority + third.getPriority + fourth.getPriority
										@fourCourses << [sum, [first, second, third, fourth]]
										# do for 5 courses
										(@num_courses-i-j-k-l).times do |m|
											fifth = @courses[i+j+k+l+m]
											if not (first.inConflict(fifth) or second.inConflict(fifth) or
											third.inConflict(fifth) or fourth.inConflict(fifth))
												sum = first.getPriority + second.getPriority + third.getPriority + fourth.getPriority + fifth.getPriority
												@fiveCourses << [sum, [first, second, third, fourth, fifth]]
												# do for 6 courses
												(@num_courses-i-j-k-l-m).times do |n|
													sixth = @courses[i+j+k+l+m+n]
													if not (first.inConflict(sixth) or second.inConflict(sixth) or
														third.inConflict(sixth) or fourth.inConflict(sixth) or 
														fifth.inConflict(sixth))
														sum = first.getPriority + second.getPriority + third.getPriority + fourth.getPriority + fifth.getPriority + sixth.getPriority
														@sixCourses << [sum, [first, second, third, fourth, fifth, sixth]]
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
			self.validateCoReq
		end
	end

	# make sure all schedules meet the co-requisite requirements
	def validateCoReq
		cur_co = 0
		# [@oneCourse, @twoCourses, ... @sixCourses]
		(@courseTable.length).times do |num_courses|
			checking = true
			i = 0
			while checking and @courseTable[num_courses+1].length > i
				schedule_array = @courseTable[num_courses+1][i]	# has format[sum,[course1, course2, ...]]
				co_req = []
				schedule_array[1].each do |course|	# get co-requisites for each course
					course.getCoReq.each do |co|	
						co_req << co 				
					end 
				end
				if co_req.length > 0
					tmp = self.singleWrapper(schedule_array)
					co_req.each do |co|
						if tmp.include? co
							cur_co+=1
						end
					end
				end
				if cur_co != co_req.length
					@courseTable[num_courses+1].delete(schedule_array)
				else
					i += 1	
					if i == @courseTable[num_courses+1].length
						checking = false
					end
				end
				cur_co = 0
				tmp = []
			end
		end
	end

	# converts one schedule of courses to string
	def singleWrapper(schedule)
		ret = []
		schedule[1].each do |course|
			ret << course.getName
		end
		return ret
	end

	# converts from array of courses class to array of strings
	def wrapper(schedules)
		ret = []
		schedules.each do |schedule|
			tmp = []
			schedule[1].each do |course|
				tmp << course.getName
			end
			ret << tmp
		end
		return ret
	end

	def getCourses
		@courses
	end

	def getSchedule(num_courses, num_schedules, prioritized)
		if num_courses > MAX_COURSES_PER_SCHEDULE or num_schedules > MAX_SCHEDULES_MADE or @num_courses == 0
			return []
		end
		if prioritized
			@courseTable[num_courses].sort!{|a, b| a[0] <=>b[0]}.reverse!
		end
		ret = self.wrapper(@courseTable[num_courses])
		ret = ret[0...num_schedules]
	end

# debug purposes
	def printConstraints
		@courses.each do |course|
			puts "
#{course.getName}
	has Conflicts:\t#{course.getConflictsNames}
	has Co-Reqs:\t#{course.getCoReq}"
		end
		puts
	end

	def printSchedule(num_courses, num_schedules)
		if num_courses > MAX_COURSES_PER_SCHEDULE or num_schedules > MAX_SCHEDULES_MADE or @num_courses == 0
			return "INVALID INPUT"
		end

		num_schedules.times do |i|
			puts "\nSchedule #{i+1}\n"
			tmp = @courseTable[num_courses].sort{|a, b| a[0] <=>b[0]}
			cur_week = Week.new()
			tmp[i][1].length.times do |j|
				cur_week.addCourse(tmp[i][1][j], j+1)
			end
			puts "Empty slot = ."
			num_courses.times do |j|
				puts "#{tmp[i][1][j].getName} = #{j+1}"
			end
			cur_week.printWeek

		end

	end 



end



