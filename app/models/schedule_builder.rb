class ScheduleBuilder < ActiveRecord::Base
    has_many :data_base

    def index
        
    end

    def create
        data = params[:order].split(',')
    end
    
    
end
