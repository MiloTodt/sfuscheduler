YEAR = '2017'.freeze    # a year to check the courses in
TERM = 'fall'.freeze  # a term to check the courses in
BASIC_API_URL = "http://www.sfu.ca/bin/wcm/course-outlines?#{YEAR}/#{TERM}/".freeze  # API Url
BUGGED_DEPARTMENTS = %w[BOT WDA DEVS FPA WCM SCD].freeze # SFU API returns some departments that actually don't have courses (so fetching them returns an error), this is a list of them

# @param [String] url - url to fetch
# @return [Hash] - response (only gets returned if response does not contain an error specified by SFU API Docs)
# if there is such error, then retry (by calling itself) until there is a valid reply
# if API keeps returning error, then this function will throw an error when the recursion gets too deep
def http_get(url)
  response = HTTParty.get(url)

  puts url

  if response.key?('errorMessage')
    puts 'error, retry...'
    begin
      http_get(url)
    rescue Net::ReadTimeout
      puts 'takes too long to respond, retry...'
      http_get(url)
    end
  else
    puts 'no error, return'
    response
  end
end

# @return [Array of Strings] - array of the departments that are offered in this term (e.g. ["cmpt", "math", "econ", ...])
def load_departments
  departments = []

  response = http_get(BASIC_API_URL)
  response.each do |department|
    departments.push(department['text'])
  end

  departments
end

# @param [String] department - name of the department to look for courses in (e.g. "educ")
# @return [Array of Strings] - array of the course numbers that are offered for this department (e.g. ["100w", "105", "120", ...])
def load_course_numbers(department)
  course_numbers = []

  response = http_get(BASIC_API_URL + "#{department}/")

  response.each do |course|
    course_numbers.push(course['text']) if course['text']
  end

  course_numbers
end

# @param [String] department - name of the department (e.g. "educ")
# @param [String] course_number - number of the course (e.g. "100w")
# @return [Array of Hashes] -  Hashes as described here http://www.sfu.ca/outlines/help/api.html#courseSections
def load_course_sections(department, course_number)
  http_get(BASIC_API_URL + "#{department}/#{course_number}/")
end


# @param [String] department - name of the department (e.g. "educ")
# @param [String] course_number - number of the course (e.g. "100w")
# @param [String] section - section of the course (e.g. "d100")
# @return [Hash] - all the information about the course

def load_course_info(department, course_number, section)
  
  course_desc = http_get(BASIC_API_URL + "#{department}/#{course_number}/#{section}/")
  puts 'course_desc:'

  require 'pp'
  pp course_desc

  return load_course_info(department, course_number, section) unless course_desc.key? 'info'

  course_parsed = {
      dept: course_desc['info']['dept'],
      number: course_desc['info']['number'],
      section: course_desc['info']['section'],
      name: course_desc['info']['name'],
      description: course_desc['info']['description'],
      title: course_desc['info']['title'],
      designation: course_desc['info']['designation'],
      prerequisites: course_desc['info']['prerequisites'],
      units: course_desc['info']['units'],
      term: course_desc['info']['term'],
      delivery_method: course_desc['info']['deliveryMethod']
  }

  # course_desc['type'] == 'n' means it is a secondary section ("TUT", "SEM", etc)
  unless course_desc['info']['type'] == 'n'
    if course_desc.key? 'instructor'
      course_parsed[:instructor_name] = course_desc['instructor'][0]['name']
      course_parsed[:instructor_email] = course_desc['instructor'][0]['email']
    else
      course_parsed[:instructor_name] = ''
      course_parsed[:instructor_email] = ''
    end

    course_parsed[:course_details] = course_desc['info']['courseDetails']
    course_parsed[:short_note] = course_desc['info']['shortNote']
  end

  schedule_string = ''
  schedule_found = false

  if course_desc.key? 'courseSchedule'
    course_desc['courseSchedule'].each do |schedule|
      if !schedule.key?('startTime') || !schedule.key?('endTime')
        next
      end

      days = schedule['days'].split(',')
      puts schedule

      days.each do |day|
        if schedule_found
          schedule_string += ';'
        else
          schedule_found = true
        end


        schedule_string += day.strip + ',' + schedule['startTime'] + ',' + schedule['endTime']

        schedule_string += ',' + schedule['campus'] if schedule.key? 'campus'
       
      end
    end
    
  end
    #To generate the courselist with schedules
        #if(course_desc['info']['type']  != 'n' && schedule_string != "" ) then File.open("output.txt", 'a') {|f| f.write(course_desc['info']['dept'] + " "+ course_desc['info']['number'] + "%" + schedule_string + "\n") }
    #end


  course_parsed[:schedule] = schedule_string

  course_parsed
end

class DataBaseController < ApplicationController

    def loadCourses #generates a file with all valid course names/number for dropdown list
      target = open("output.txt", 'w')
    # first delete all the courses from the database
    courses = {}

    departments = load_departments

    # remove bugged departments (API returns an error if you try to load them)
    # from the departments list
    BUGGED_DEPARTMENTS.each do |bugged_department|
      departments.delete(bugged_department)
    end

    # sleep(5)

    #
    departments.each do |department|
      # sleep(1)
      courses[department] = {}

      course_numbers = []

      while course_numbers.empty?
        course_numbers = load_course_numbers(department)
      end

      puts department
      # puts course_numbers

      course_numbers.each do |course_number|
        course_sections = load_course_sections(department, course_number)
        associated_classes = []

        course_sections.each do |section|
          unless associated_classes.include? section['associatedClass']
            associated_classes.push section['associatedClass']
          end
        end

        courses[department][course_number] = {}

        associated_classes.each do |associated_class|
          primary_course = course_sections.find { |course| course['classType'] == 'e' and course['associatedClass'] == associated_class}
          secondary_courses = course_sections.find_all { |course| course['classType'] == 'n'  and course['associatedClass'] == associated_class}

          next unless primary_course

          primary_course['has_secondary'] = !secondary_courses.empty?

          courses[department][course_number][associated_class] = {}
          courses[department][course_number][associated_class]['primary'] = primary_course
          courses[department][course_number][associated_class]['secondary'] = secondary_courses

           target.write("<option value=\""+ department + " "+ course_number + "\">\n") #for html drop down
  



        end

      end
    end

    # puts departments

    require 'pp'
    pp courses

  end
  
  def load
    # first delete all the courses from the database
    PrimaryCourse.delete_all
    SecondaryCourse.delete_all

    courses = {}

    departments = load_departments

    # remove bugged departments (API returns an error if you try to load them)
    # from the departments list
    BUGGED_DEPARTMENTS.each do |bugged_department|
      departments.delete(bugged_department)
    end

    # sleep(5)

    #
    departments.each do |department|
      # sleep(1)
      courses[department] = {}

      course_numbers = []

      while course_numbers.empty?
        course_numbers = load_course_numbers(department)
      end

      puts department
      # puts course_numbers

      course_numbers.each do |course_number|
        course_sections = load_course_sections(department, course_number)
        associated_classes = []

        course_sections.each do |section|
          unless associated_classes.include? section['associatedClass']
            associated_classes.push section['associatedClass']
          end
        end

        courses[department][course_number] = {}

        associated_classes.each do |associated_class|
          primary_course = course_sections.find { |course| course['classType'] == 'e' and course['associatedClass'] == associated_class}
          secondary_courses = course_sections.find_all { |course| course['classType'] == 'n'  and course['associatedClass'] == associated_class}

          next unless primary_course

          primary_course['has_secondary'] = !secondary_courses.empty?

          courses[department][course_number][associated_class] = {}
          courses[department][course_number][associated_class]['primary'] = primary_course
          courses[department][course_number][associated_class]['secondary'] = secondary_courses

          @primary_course = PrimaryCourse.create(load_course_info(department, course_number, primary_course['text']))
          secondary_courses.each do |secondary_course|
            @primary_course.secondary_courses.create(load_course_info(department, course_number, secondary_course['text']))
          end
        end

      end
    end

    # puts departments

    require 'pp'
    pp courses

  end
end