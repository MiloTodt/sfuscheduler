class ScheduleBuilder < ActiveRecord::Base
    has_many :data_base

    def index
        data = params[:order].split(',')
    end
    
end
