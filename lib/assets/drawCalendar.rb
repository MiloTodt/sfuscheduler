# drawCakebdar.rb


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
def makeWeek
    week = []
    7.times do |x|
        week << Day.new(DAYS[x])
    end
    return week
end


#=====================================================================
# classes
#=====================================================================

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


class Day
    def initialize(name)
        @name = name
        @courses = []
    end
    def addCourse(courseName, startTime, endTime)
        @courses << [courseName, startTime, endTime] #appends to end of the course array
    end
    def getName()
        @name
    end
    def printCourses()
        @courses.each do |course|
            puts course
        end
    end      
end
monday = Day.new("Monday")
monday.addCourse("CMPT 276", "1430", "1520")
monday.addCourse("CMPT 3423", "530", "620")
monday.printCourses()

week = makeWeek

class Course
    @@numOfCourses = 0
    @times = Array.new()
    def initialize(name, times) #times is an array of course times
        @name = name
        if times.length > 0 then
            times.each do |time|
                @times << time
            end
        end
        @@numOfCourses++
    end
end

    





week = makeWeek()
added = [false]
schedule = []
tmp = []

