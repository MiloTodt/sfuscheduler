# drawCalendar.rb


#=====================================================================
# CONSTANTS
#=====================================================================
DAYS = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

START_TIMES = {"830" => 0, "930" => 1, "1030" => 2, "1130"=>3, "1230"=>4,
"1330"=>5, "1430"=>6, "1530"=>7, "1630"=>8, "1730"=>9, "1830"=>10, 
"1930"=>11, "2030"=>12}

END_TIMES = {"920" => 0, "1020" => 1, "1120" => 2, "1220"=>3, "1320"=>4,
"1420"=>5, "1520"=>6, "1620"=>7, "1720"=>8, "1820"=>9, "1920"=>10, 
"2020"=>11, "2120"=>12}

#=====================================================================
# Methods
#=====================================================================
def makeWeek(courseList) #builds an array of Days and adds Courses to each Day
    week = []
    7.times do |x|
        week << Day.new(DAYS[x])
        courseList.each{|course|
        if course.getDays.index(x) != nil then #course is on this day
            course.getTimes().each{|time| if time[0] == x then week[x].addCourse(Course.new(course.getName, time)) end } #adds the course block to this day
            puts "added #{course.getName()}" 
        end
        }
    end
    return week
end


#=====================================================================
# Classes
#=====================================================================
class Course
    def initialize(name, times) #times is an array of course times
        @times = [] # ["Monday", "1230", "1330"] day, start, end
        @name = name
        if times.length > 0 then
            times.each do |time|
                @times << time
            end
        end
    end
    def getName
        @name
    end
    def getTotalNumberOfCourses
        @@numOfCourses
    end
    def getTimes
        outTimes = []
        @times.each do |time|
            outTimes << time
        end
        return outTimes
    end  
    def getDays
        days =[]
        @times.each{|time| days << time[0]}
        return days
    end
end

class Day
    def initialize(name)
        @name = name
        @courses = []
        @numOfCourses = 0
    end
    def addCourse(inCourse)
        @courses << inCourse
        @numOfCourses +=1
    end
    def getName()
        @name
    end
    def getNumOfCourses
        @numOfCourses
    end
    def printCourses()
        @courses.each do |course|
            puts course.getName()
            puts course.getTimes()
        end
    end      
end
#=====================================================================
# Main
#=====================================================================

#=====================================================================
# WORK IN PROGRESS view anything after this as a sandbox
#=====================================================================
# courseList = [
# 	["CMPT 276", [["M", "1430", "1520"], ["W", "1430", "1520"], ["F", "1430", "1520"]] ],
# 	["CMPT 295", [["M", "1530", "1620"], ["W", "1530", "1620"], ["F", "1530", "1620"]] ],
# 	["CMPT 320", [["M", "1630", "1720"], ["W", "1630", "1720"], ["F", "1630", "1720"]] ],
# 	["CMPT 371", [["M", "1430", "1720"], ["F", "930", "1020"]] ],
# 	["CMPT 391", [["M", "830", "1020"],  ["F", "830", "920"]] ],
# ]
courseList = [
	["CMPT 276", [[0, "1430", "1520"], [2, "1430", "1520"], [4, "1430", "1520"]] ],
	["CMPT 295", [[0, "1530", "1620"], [2, "1530", "1620"], [4, "1530", "1620"]] ],
	["CMPT 320", [[0, "1630", "1720"], [2, "1630", "1720"], [4, "1630", "1720"]] ],
	["CMPT 371", [[0, "1430", "1720"], [4, "930", "1020"]] ],
	["CMPT 391", [[0, "830", "1020"],  [4, "830", "920"]] ],
]

#Wrapper to convert Brain's format to my current one
allCourses = []
courseList.each{|course|
    allCourses << Course.new(course[0],course[1])
}
week = makeWeek(allCourses)

allCourses.each{|course| 
    puts course.getName()
}
allCourses.each{|course| puts course.getTimes}


monday = Day.new("Monday")
course1 = Course.new("CMPT 391", [[0, "830", "1020"],  [4, "830", "920"]])
course2 = Course.new("MACM 222", [1, "130", "320"])
monday.addCourse(course1)
monday.addCourse(course2)
monday.printCourses()
