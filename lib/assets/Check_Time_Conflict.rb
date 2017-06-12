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
DAYS = {"M" => 0, "T" => 1, "W" => 2, 
	"TH" => 3, "F" => 4, "S" => 5, "SU" => 6}

START_TIMES = {"830" => 0, "930" => 1, "1030" => 2, "1130"=>3, "1230"=>4,
"1330"=>5, "1430"=>6, "1530"=>7, "1630"=>8, "1730"=>9, "1830"=>10, 
"1930"=>11, "2030"=>12}

END_TIMES = {"920" => 0, "1020" => 1, "1120" => 2, "1220"=>3, "1320"=>4,
"1420"=>5, "1520"=>6, "1620"=>7, "1720"=>8, "1820"=>9, "1920"=>10, 
"2020"=>11, "2120"=>12}

#=====================================================================
# Methods
#=====================================================================
def makeWeek
	week = []
	7.times do
		day = [] 
		12.times do 
			day.push(0)
		end
		week.push(day)
	end
	return week
end

def printWeek(week)
	timeSlots = 830
	puts "TIMES\tM\tT\tW\tTH\tF\tS\tSU"
	12.times {|hour|
		print "#{timeSlots}\t" 
		if timeSlots < 1000
			print"\t"
		end
		timeSlots = timeSlots + 100 
		7.times {|day|
			print "#{week[day][hour]}\t"
		}
		puts
	}
end
	
def addCourse(course, week, added)
	cp = week
	adding = course[0]
	days = (course.length)-1
	(days).times {|day|
		currentDay = DAYS[course[day+1][0]]
		start_t = START_TIMES[course[day+1][1]]
		end_t = END_TIMES[course[day+1][2]]
		if week[currentDay][start_t] == 0
			week[currentDay][start_t] = 1
		else
			return cp
		end
		(end_t-start_t).times {|hour|
			if week[currentDay][start_t+hour+1] == 0
				week[currentDay][start_t+hour+1] = 1
			else
				return cp
			end
		}
	}
	added[0] = true
end

#=====================================================================
# Main
#=====================================================================
courseList = [
	["CMPT 276", ["M", "1430", "1520"], ["W", "1430", "1520"], ["F", "1430", "1520"] ],
	["CMPT 295", ["M", "1530", "1620"], ["W", "1530", "1620"], ["F", "1530", "1620"] ],
	["CMPT 320", ["M", "1630", "1720"], ["W", "1630", "1720"], ["F", "1630", "1720"] ],
	["CMPT 371", ["M", "1430", "1720"], ["F", "930", "1020"] ],
	["CMPT 391", ["M", "830", "1020"],  ["F", "830", "920"] ],
]


week = makeWeek()
added = [false]
schedule = []
tmp = []

# Generate schedule of 1 class
courseList.times{|course|
	tmp.push
}

# Generate schedule of 2 classes

# Generate schedule of 3 classes

# Generate schedule of 4 classes

# Generate schedule of 5 classes






# numCourse.times{
# 	courseList.length.times{|course|
# 		addCourse(courseList[course], week, added)
# 		if added[0]
# 			schedule.push(courseList[course][0])
# 			added[0] = false
# 		end	
# 	}
# }
# p schedule
