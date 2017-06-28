class PrimaryCourse < ActiveRecord::Base
  has_many :secondary_courses
end
