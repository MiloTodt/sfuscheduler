require 'test/unit'
require_relative 'scheduleGenerator'

class SchedulerTester < Test::Unit::TestCase
	def setup
		@case1 = []
		@number_of_courses = 0
		@number_of_schedules = 0
		prioritized = false
	end
	def test_case1
		puts "TESTING EMPTY LIST"
		test = Scheduler.new(@case1)
		assert_equal [], test.getSchedule(@number_of_courses,@number_of_schedules,@prioritized)
	end
end