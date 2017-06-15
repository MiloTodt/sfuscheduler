require_relative 'scheduleGenerator'

# Used to test scheduleGenerator
# refer to this doc for course input layout
# can support more than 10 courses, but will slow down
# priority_number indicates level of priority user wants to take the course
# higher number = higher priority
# 0 is lowest priority
low = 0
mid = 1
high = 2
highest = 3
priority_number = [low, mid, high, highest]
# use this example
# array of courses
# courses include
# ["course name", priority_number, 
# [[day, start_time, end_time, location],[day, start_time, end_time, location],[day, start_time, end_time, location]], 
# [["pre-requisites", "course_1"], ["co-requisites", "course_2"]] 
# ]
# may include pre-req and co-req in later versions but will be listed afterwards
courses = [
	["course_name_1",  low, 	[["M",  "830", "1120", "Burnaby"]], [] ], 
	["course_name_2",  low, 	[["T", "1530", "1820", "Burnaby"]], [] ],
	["course_name_3",  low, 	[["TH","1430", "1720", "Burnaby"]], [] ],
	["course_name_4",  mid, 	[["M", "930" , "1120", "Burnaby"], 	["W", "930", "1020", "Burnaby"]] , 	[]],
	["course_name_5",  mid, 	[["M", "1230", "1420", "Burnaby"], 	["W", "1230", "1320", "Burnaby"]], 	[] ],
	["course_name_6",  mid, 	[["W", "1230", "1420", "Burnaby"], 	["F", "1230", "1320", "Burnaby"]], 	[] ],
	["course_name_7",  high,	[["T", "1430", "1620", "Burnaby"], 	["TH", "1430", "1520", "Burnaby"]], [] ],
	["course_name_8",  high, 	[["T", "1430", "1620", "Burnaby"], 	["TH", "1430", "1520", "Burnaby"]], [] ], 
	["course_name_9",  high, 	[["M", "930" , "1020", "Burnaby"], 	["W", "930" , "1020", "Burnaby"], 	["F", "930" , "1020", "Burnaby"]], 	[] ],
	["course_name_10", highest, [["M", "1130" , "1220", "Surrey"],	["W", "1130" , "1220", "Burnaby"], 	["F", "1130" , "1220", "Burnaby"]], [] ],
	["course_name_11", highest, [["M", "2030" , "2120", "Burnaby"],	["W", "2030" , "2120", "Burnaby"], 	["F", "2030" , "2120", "Burnaby"]], [] ],
	["course_name_12", highest, [["M", "1830" , "1920", "Burnaby"],	["W", "1830" , "1920", "Burnaby"], 	["F", "1830" , "1920", "Burnaby"]], [] ],
]

test = Scheduler.new(courses)

test.printConflicts
number_of_courses = 1	# change this number from 1-6 to get schedules of that amount
print "MAKING SCHEDULE OF #{number_of_courses} COURSES\n"
p test.getSchedule(number_of_courses)	# prints out array of schedules
p test.getPrioritySchedule(number_of_courses)	# prints our array of schedules lead by their priority number
