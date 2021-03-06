require_relative 'scheduleGenerator'

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
	["course_name_1",  highest, [["M",  "830", "1120", "Burnaby"]], [["CO", "course_name_2"],["PRE", "course_name_3"]] ], 
	["course_name_2",  highest, [["T", "1530", "1820", "Burnaby"]], [["CO", "course_name_1"]] ],
	["course_name_3",  highest, [["TH","1430", "1720", "Burnaby"]], [["CO", "course_name_5"]] ],
	["course_name_4",  mid, 	[["M", "930" , "1120", "Burnaby"], 	["W", "930", "1020", "Burnaby"]] , 	[["PRE", "course_name_3"]]],
	["course_name_5",  mid, 	[["M", "1230", "1420", "Burnaby"], 	["W", "1230", "1320", "Burnaby"]], 	[["CO", "course_name_3"]] ],
	["course_name_6",  low, 	[["W", "1230", "1420", "Burnaby"], 	["F", "1230", "1320", "Burnaby"]], 	[] ],
	["course_name_7",  high,	[["T", "1430", "1620", "Burnaby"], 	["TH", "1430", "1520", "Burnaby"]], [] ],
	["course_name_8",  mid, 	[["T", "1430", "1620", "Burnaby"], 	["TH", "1430", "1520", "Burnaby"]], [] ], 
	["course_name_9",  high, 	[["M", "930" , "1020", "Burnaby"], 	["W", "930" , "1020", "Burnaby"], 	["F", "930" , "1020", "Burnaby"]], 	[] ],
	["course_name_10", highest, [["M", "1130" , "1220", "Surrey"],	["W", "1130" , "1220", "Burnaby"], 	["F", "1130" , "1220", "Burnaby"]], [] ],
	["course_name_11", low,	 	[["M", "2030" , "2120", "Burnaby"],	["W", "2030" , "2120", "Burnaby"], 	["F", "2030" , "2120", "Burnaby"]], [] ],
	["course_name_12", highest, [["M", "1830" , "1920", "Burnaby"],	["W", "1830" , "1920", "Burnaby"], 	["F", "1830" , "1920", "Burnaby"]], [] ],
]

test = Scheduler.new(courses)
number_of_courses = 6		# change this number from 1-6 to get schedules of that amount
number_of_schedules = 1		# returns the number of schedules or less
prioritized = true			# true => returns in order of highest priority, false=> priority doesn't matter
tmp = test.getSchedule(number_of_courses, number_of_schedules, prioritized)	# prints our array of schedules lead by their priority number

n = 1
test.printConstraints
print "PRINTING #{number_of_schedules} SCHEDULE(S) OF #{number_of_courses} COURSE(S)\n"
tmp.each do |i|
	print "Schedule #{n}: #{i}\n"
	n += 1
end
test.printSchedule(number_of_courses, number_of_schedules)


