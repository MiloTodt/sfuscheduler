# Check_Time_Conflict.rb
# Takes in an array of courses in the form of 
# [
# ["Course Name", ["Day", Start_Time, End_Time], ["Day", Start_Time, End_Time], ...]
# ["Course Name", ["Day", Start_Time, End_Time], ["Day", Start_Time, End_Time], ...]
# ...
# ]
# maximum  courses
# returns an array of valid schedules 
# checks for time, location, conflicts
# matches labs with classes & priorities
# For Example
# Given Course_1, Course_2, Course_3, Course_4 
# where Course_1 conflicts with Course_4
# where Course_2 conflicts with Course_3
# return
# [
# ["Course_1"], ["Course_2"], ["Course_3"], ["Course_4"], 
# ["Course_1", "Course_2"], ["Course_1", "Course_3"], 
# ["Course_4", "Course_2"], ["Course_4", "Course_3"], 
# ]
# separate unit send out one schedule at a time will be done in integration module


#=====================================================================
# CONSTANTS
#=====================================================================
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

#=====================================================================
# Day Class
#=====================================================================
class Day 
	def initialize(name)
		@name = name
		@hours = []
		HOURS.length.times do 
			@hours << 0
		end
	end

	def getName()
		@name
	end

	def getHour(hour)
		@hours[START_TIMES[hour]]
	end

	def setHours(start_t, end_t)
		# clone day incase it fails
		clone = []
		clone.replace(@hours)
		starting = START_TIMES[start_t]
		duration = END_TIMES[end_t] - starting
		if @hours[starting] == 0
			@hours[starting] = 1
		else
			@hours.replace(clone)
			return false
		end
		starting += 1
		duration.times do |cur_hour|
			if @hours[cur_hour+starting] == 0
				@hours[cur_hour+starting] = 1
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
	def addCourse(course)
		# make clone in case of fail
		clone = []
		clone.replace(@days)
		tmp = course.getDates()
		tmp.length.times do |day|
			cur_day = tmp[day][CONVERT["DAY"]]
			start_t = tmp[day][CONVERT["START"]]
			end_t = tmp[day][CONVERT["END"]]
			if not @days[DAYS[cur_day]].setHours(start_t, end_t)
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
		@requisites = []
		if dates.length > 0
			dates.each do |date|
				@dates << date
			end
		end
		if requisites.length > 0
			requisites.each do |requisite|
				@requisites << requisite
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

	# check if course is in @conflicts
	def inConflict(course)
		@conflicts.each do |conflict|
			if conflict == course
				return true
			end
		end
		if self == course
			return true
		end
		return false
	end

	# check if self has conflicts with course location and time wise
	def checkConflict(course)
		if self.checkDupe(course) and 
		(self.checkLocationConflict(course) or self.checkTimeConflict(course))
			@conflicts << course
		end

	end

	# check if comparing with self or if already in conflicts
	def checkDupe(course)
		if not self == course 
			if not self.inConflict(course)
				return true
			end
		end
		return false
	end


	def checkTimeConflict(course)
		check = Week.new()
		check.addCourse(self)
		if not check.addCourse(course)
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
		if @num_courses > 0
			# do for 1 course
			@num_courses.times do |i|
				first = @courses[i]
				sum = first.getPriority
				@oneCourse << [sum, [first]]
				# Do for 2 course
				(@num_courses-i).times do |j|
					second = @courses[i+j]
					if not first.inConflict(second)
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
		end
	end

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
		if prioritized
			@courseTable[num_courses].sort!{|a, b| a[0] <=>b[0]}.reverse!
		end
		ret = self.wrapper(@courseTable[num_courses])
		ret = ret[0...num_schedules]
	end

# debug purposes
	def printConflicts
		@courses.each do |course|
			puts "#{course.getName} has conflicts with #{course.getConflictsNames}"
		end
		puts
	end
end



