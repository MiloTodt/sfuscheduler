# Check_Time_Conflict.rb
# Takes in an array of courses in the form of 
# [
# ["Course Name", ["Day", Start_Time, End_Time], ["Day", Start_Time, End_Time], ...]
# ["Course Name", ["Day", Start_Time, End_Time], ["Day", Start_Time, End_Time], ...]
# ...
# ]
# maximum 10 courses
# returns an array of valid schedules 
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


#=====================================================================
# CONSTANTS
#=====================================================================
WEEK = ["M", "T", "W", "TH", "F", "S", "SU"]

HOURS = ["830", "930", "1030", "1130", "1230", "1330", "1430",
		"1530", "1630", "1730", "1830", "1930", "2030"]

DAYS = {"M" => 0, "T" => 1, "W" => 2, 
	"TH" => 3, "F" => 4, "S" => 5, "SU" => 6}

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
			@hours.push(0)
		end
	end

	def getName()
		@name
	end

	def getHour(hour)
		@hours[START_TIMES[hour]]
	end

	def setHours(start_t, end_t)
		# clone week incase it fails
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
			@days.push(Day.new(WEEK[day]))
		end
		@courses = []
	end

	

	def getCourses()
		@courses
	end

	def addCourse(course)
		# make clone in case of fail
		clone = []
		clone.replace(@days)
		tmp = course.getDates()
		tmp.length.times do |day|
			cur_day = tmp[day][0]
			start_t = tmp[day][1]
			end_t = tmp[day][2]
			if not @days[DAYS[cur_day]].setHours(start_t, end_t)
				@days.replace(clone)
				return false
			end
		end

		@courses.push(course.getName)
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
	# dates = [[day_1, start, end],...[day_n, start, end]]
	def initialize(name, id, dates) 
		@name = name
		@id = id
		@dates = []
		@conflicts = []
		if dates.length > 0
			dates.each do |date|
				@dates << date
			end
		end
	end

	def ==(course)
		if @name == course.getName and @id == course.getId
			return true
		end
		return false
	end

	def getName
		@name
	end

	def getId
		@id
	end

	def getDates
		@dates
	end

	def getConflicts
		@conflicts
	end 

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

	def checkConflict(course)
		check = Week.new()
		check.addCourse(self)
		if (not check.addCourse(course)) and not (self == course) and not self.inConflict(course)
			@conflicts.push(course)
		end
	end

# debug purposes
	def getConflictsNames
		ret = []
		if @conflicts.length > 0
			@conflicts.each do |conflict|
				ret.push(conflict.getName)
			end
		end
		return ret
	end


end



#=================================================================
# Scheduler Class
#=================================================================
class Scheduler
# input has the form of courses = [
# ["Course_name_1", [["M", "930" , "1120"]], ..., ["SU", "930" , "1120"]],
# ...
# ["Course_name_N", [["M", "930" , "1120"]], ..., ["SU", "930" , "1120"]],
# ]
	def initialize (courses)
		@courses = []
		@num_courses = courses.length
		@oneCourse = []
		@twoCourses = []
		@threeCourses = []
		@fourCourses = []
		@fiveCourses = []

		if @num_courses > 0
			courses.each do |course|
				@courses.push(Course.new(course[0], course[1], course[2]))
			end
			self.compareConflicts()
		end
	end

	def compareConflicts()
		@courses.each do |checking|
			@courses.each do |check_with|
				checking.checkConflict(check_with)
			end
		end
	end

	def getCourses
		@courses
	end

	def genOneCourse
		if @num_courses > 0 
			ret = [] 
			@courses.each do |course|
				@oneCourse.push([course])
			end
			# converts array of courses to array of strings of course names
			ret = self.wrapper(@oneCourse)
		end
		return ret

	end

	def genTwoCourses
		if @num_courses > 0
			ret = []

			@num_courses.times do |i|
				added = @courses[i]
				(@num_courses-i).times do |j|
					adding = @courses[j+i]
					tmp = [added]
					if not added.inConflict(adding) 
						tmp.push(adding)
						@twoCourses.push(tmp)
					end
				end
			end

			# return array of course names as string
			ret = self.wrapper(@twoCourses)
		end
		return ret
	end
	
	def genThreeCourses
		ret = []
		if @num_courses > 0
			@num_courses.times do |i|
				first = @courses[i]
				(@num_courses-i).times do |j|
					second = @courses[i+j]
					(@num_courses-i-j).times do |k|
						third = @courses[i+j+k]
						if ( not (first.inConflict(second) or 
							first.inConflict(third) or 
							second.inConflict(third)) )
							tmp = [first, second, third]
							@threeCourses.push(tmp)
						end
					end
				end
				
			end
			ret = self.wrapper(@threeCourses)
		end
		return ret
	end

	def genFourCourses
		ret = []
		if @num_courses > 0
			@num_courses.times do |i|
				first = @courses[i]
				(@num_courses-i).times do |j|
					second = @courses[i+j]
					(@num_courses-i-j).times do |k|
						third = @courses[i+j+k]
						(@num_courses-i-j-k).times do |l|
							fourth = @courses[i+j+k+l]
							if (not (first.inConflict(second) or first.inConflict(third) or 
								first.inConflict(fourth) or second.inConflict(third) or 
								second.inConflict(fourth) or third.inConflict(fourth) ))
								tmp = [first, second, third, fourth]
								@fourCourses.push(tmp)
							end
						end
					end
				end
				
			end
			ret = self.wrapper(@fourCourses)
		end
		return ret
	end
	
	def genFiveCourses
		ret = []
		if @num_courses > 0
			@num_courses.times do |i|
				first = @courses[i]
				(@num_courses-i).times do |j|
					second = @courses[i+j]
					(@num_courses-i-j).times do |k|
						third = @courses[i+j+k]
						(@num_courses-i-j-k).times do |l|
							fourth = @courses[i+j+k+l]
							(@num_courses-i-j-k-l).times do |m|
								fifth = @courses[i+j+k+l+m]
								
								if (not (first.inConflict(second) or first.inConflict(third) or 
									first.inConflict(fourth) or first.inConflict(fifth) or 
									second.inConflict(third) or second.inConflict(fourth) or 
									second.inConflict(fifth) or third.inConflict(fourth) or 
									third.inConflict(fifth) or fourth.inConflict(fifth) ) )

									tmp = [first, second, third, fourth, fifth]
									@fiveCourses.push(tmp)
								end
							end
						end
					end
				end
				
			end
			ret = self.wrapper(@fiveCourses)
		end
		return ret
	end

	def wrapper(schedules)
		ret = []
		schedules.each do |schedule|
			tmp = []
			schedule.each do |course|
				tmp.push(course.getName)
			end
			ret.push(tmp)
		end
		return ret
	end

# debug purposes

	def printConflicts
		@courses.each do |course|
			puts "#{course.getName} has conflicts with #{course.getConflictsNames}"
		end
		puts
	end
end



#=====================================================================
# Main
#=====================================================================
# Get input

# Generate schedule of 1 class

# Generate schedule of 2 classes

# Generate schedule of 3 classes

# Generate schedule of 4 classes

# Generate schedule of 5 classes

# return all schedules