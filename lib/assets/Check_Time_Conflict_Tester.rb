require_relative 'Check_Time_Conflict'

courses = [
	["A", "D100", [["M", "930" , "1120"]] ],
	["B", "D100",[["M", "930" , "1020"]] ],
	["C", "D100",[["M", "1030", "1220"]] ],
	["D", "D100",[["M", "1230", "1320"]] ],
	["E", "D100",[["M", "1530", "1620"], ["W", "1530", "1620"]] ],
	["F", "D100",[["M", "1530", "1620"]] ],
]

test = Scheduler.new(courses)

test.printConflicts

puts "1 Course Schedule:"
p test.genOneCourse()
puts "2 Courses Schedule:"
p test.genTwoCourses()
puts "3 Courses Schedule:"
p test.genThreeCourses()
puts "4 Courses Schedule:"
p test.genFourCourses()
puts "5 Courses Schedule:"
p test.genFiveCourses()
