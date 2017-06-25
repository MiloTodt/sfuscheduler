class CourseSchedule < ActiveRecord::Base
    has_many :sfucourse, :dependent => :destroy
    accepts_nested_attributes_for :sfucourse
end
