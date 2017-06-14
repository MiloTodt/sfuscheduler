require_relative 'scheduleGenerator'

# Used to test scheduleGenerator
# refer to this doc for course input layout
# can support more than 10 courses, but will slow down
# priority_number indicates level of priority user wants to take the course
# higher number = higher priority
# 0 is lowest priority

priority_number = 0
# use this example
# array of courses
# courses include
# ["course name", priority_number, [[day, start_time, end_time, location],[day, start_time, end_time, location],[day, start_time, end_time, location] ]]
# may include pre-req and co-req in later versions but will be listed afterwards
courses = [
	["course_name_1",  priority_number, [["M",  "830", "1120", "Burnaby"]], [] ], 
	["course_name_2",  priority_number, [["T", "1530", "1820", "Burnaby"]], [] ],
	["course_name_3",  priority_number, [["TH","1430", "1720", "Burnaby"]], [] ],
	["course_name_4",  priority_number, [["M", "930" , "1120", "Burnaby"], ["W", "930", "1020", "Burnaby"]] , []],
	["course_name_5",  priority_number, [["M", "1230", "1420", "Burnaby"], ["W", "1230", "1320", "Burnaby"]], [] ],
	["course_name_6",  priority_number, [["W", "1230", "1420", "Burnaby"], ["F", "1230", "1320", "Burnaby"]], [] ],
	["course_name_7",  priority_number, [["T", "1430", "1620", "Burnaby"], ["TH", "1430", "1520", "Burnaby"]], [] ],
	["course_name_8",  priority_number, [["T", "1430", "1620", "Burnaby"], ["TH", "1430", "1520", "Burnaby"]], [] ], 
	["course_name_9",  priority_number, [["M", "930" , "1020", "Burnaby"], ["W", "930" , "1020", "Burnaby"], ["F", "930" , "1020", "Burnaby"]], [] ],
	["course_name_10", priority_number, [["M", "1230" , "1320", "Burnaby"],["W", "1230" , "1320", "Burnaby"], ["F", "1230" , "1320", "Burnaby"]], [] ],
	["course_name_11", priority_number, [["M", "2030" , "2120", "Burnaby"],["W", "2030" , "2120", "Burnaby"], ["F", "2030" , "2120", "Burnaby"]], [] ],
]

test = Scheduler.new(courses)

test.printConflicts

puts "1 Course Schedule:"
p test.get1
puts "2 Courses Schedule:"
p test.get2
puts "3 Courses Schedule:"
p test.get3
puts "4 Courses Schedule:"
p test.get4
puts "5 Courses Schedule:"
p test.get5