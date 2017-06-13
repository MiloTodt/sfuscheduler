# drawCakebdar.rb


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

#=====================================================================
# WORK IN PROGRESS view anything after this as a sandbox
#=====================================================================
courseList = [
	["CMPT 276", [["M", "1430", "1520"], ["W", "1430", "1520"], ["F", "1430", "1520"]] ],
	["CMPT 295", [["M", "1530", "1620"], ["W", "1530", "1620"], ["F", "1530", "1620"]] ],
	["CMPT 320", [["M", "1630", "1720"], ["W", "1630", "1720"], ["F", "1630", "1720"]] ],
	["CMPT 371", [["M", "1430", "1720"], ["F", "930", "1020"]] ],
	["CMPT 391", [["M", "830", "1020"],  ["F", "830", "920"]] ],
]

allCourses = []
courseList.each{|course|
    allCourses << Course.new(course[0],course[1])
}
allCourses.each{|course| 
    puts course.getName()
}


class Day
    def initialize(name)
        @name = name
        @courses = []
        @numOfCourses += 1
    end
    def addCourse(inCourse)
        @courses << inCourse
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
    def initialize(name, times) #times is an array of course times
        @times = [] # ["Monday", "1230", "1330"] day, start, end
        @name = name
        if times.length > 0 then
            times.each do |time|
                @times << time
            end
        end
        @@numOfCourses += 1
    end
    def getName
        @name
    end
    def getTotalNumberOfCourses
        @@numOfCourses
    end
    def getStartTimes
        @times.each do |startTime|
            puts times[1]
        end
    end  
end
course1 = Course.new("CMPT 391", [["M", "830", "1020"],  ["F", "830", "920"]])
course2 = Course.new("MACM 222", ["Tuesday", "130", "320"])
monday.addCourse(course1)
monday.addCourse(course2)
monday.getStartTimes





week = makeWeek()
added = [false]
schedule = []
tmp = []

