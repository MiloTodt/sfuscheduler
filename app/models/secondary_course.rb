class SecondaryCourse < ActiveRecord::Base
  belongs_to :primary_course
end
