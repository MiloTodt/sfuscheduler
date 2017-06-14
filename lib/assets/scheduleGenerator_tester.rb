require_relative 'scheduleGenerator'

courses = [
	["c1", "D100",  "Burnaby",  [["M",  "830", "1120"]] ],
	#["c2", "D100",  "Burnaby",  [["T", "1530", "1820"]] ],
	#["c3", "D100",  "Burnaby",  [["TH","1430", "1720"]] ],
	["c4", "D100",  "Burnaby",  [["M", "930" , "1120"], ["W", "930", "1020"]] ],
	["c5", "D100",  "Burnaby", [["M", "1230", "1420"], ["W", "1230", "1320"]] ],
	["c6", "D100",  "Burnaby", [["W", "1230", "1420"], ["F", "1230", "1320"]] ],
	#["c7", "D100",  "Burnaby", [["T", "1430", "1620"], ["TH", "1430", "1520"]] ],
	#["c8", "D100",  "Burnaby", [["T", "1430", "1620"], ["TH", "1430", "1520"]] ], 
	#["c9", "D100",  "Burnaby", [["M", "930" , "1020"],	["W", "930" , "1020"], ["F", "930" , "1020"]] ],
	#["c10","D100",	"Burnaby", [["M", "1230" , "1320"],["W", "1230" , "1320"], ["F", "1230" , "1320"]] ],
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