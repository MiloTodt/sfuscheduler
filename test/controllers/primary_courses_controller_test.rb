require 'test_helper'

class PrimaryCoursesControllerTest < ActionController::TestCase
  setup do
    @primary_course = primary_courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:primary_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create primary_course" do
    assert_difference('PrimaryCourse.count') do
      post :create, primary_course: { course_details: @primary_course.course_details, delivery_method: @primary_course.delivery_method, dept: @primary_course.dept, description: @primary_course.description, designation: @primary_course.designation, instructor_email: @primary_course.instructor_email, instructor_name: @primary_course.instructor_name, name: @primary_course.name, number: @primary_course.number, prerequisites: @primary_course.prerequisites, schedule: @primary_course.schedule, section: @primary_course.section, short_note: @primary_course.short_note, term: @primary_course.term, title: @primary_course.title, units: @primary_course.units }
    end

    assert_redirected_to primary_course_path(assigns(:primary_course))
  end

  test "should show primary_course" do
    get :show, id: @primary_course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @primary_course
    assert_response :success
  end

  test "should update primary_course" do
    patch :update, id: @primary_course, primary_course: { course_details: @primary_course.course_details, delivery_method: @primary_course.delivery_method, dept: @primary_course.dept, description: @primary_course.description, designation: @primary_course.designation, instructor_email: @primary_course.instructor_email, instructor_name: @primary_course.instructor_name, name: @primary_course.name, number: @primary_course.number, prerequisites: @primary_course.prerequisites, schedule: @primary_course.schedule, section: @primary_course.section, short_note: @primary_course.short_note, term: @primary_course.term, title: @primary_course.title, units: @primary_course.units }
    assert_redirected_to primary_course_path(assigns(:primary_course))
  end

  test "should destroy primary_course" do
    assert_difference('PrimaryCourse.count', -1) do
      delete :destroy, id: @primary_course
    end

    assert_redirected_to primary_courses_path
  end
end
