require 'test_helper'

class SecondaryCoursesControllerTest < ActionController::TestCase
  setup do
    @secondary_course = secondary_courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:secondary_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create secondary_course" do
    assert_difference('SecondaryCourse.count') do
      post :create, secondary_course: { course_details: @secondary_course.course_details, delivery_method: @secondary_course.delivery_method, dept: @secondary_course.dept, description: @secondary_course.description, designation: @secondary_course.designation, name: @secondary_course.name, number: @secondary_course.number, prerequisites: @secondary_course.prerequisites, schedule: @secondary_course.schedule, section: @secondary_course.section, term: @secondary_course.term, title: @secondary_course.title, units: @secondary_course.units }
    end

    assert_redirected_to secondary_course_path(assigns(:secondary_course))
  end

  test "should show secondary_course" do
    get :show, id: @secondary_course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @secondary_course
    assert_response :success
  end

  test "should update secondary_course" do
    patch :update, id: @secondary_course, secondary_course: { course_details: @secondary_course.course_details, delivery_method: @secondary_course.delivery_method, dept: @secondary_course.dept, description: @secondary_course.description, designation: @secondary_course.designation, name: @secondary_course.name, number: @secondary_course.number, prerequisites: @secondary_course.prerequisites, schedule: @secondary_course.schedule, section: @secondary_course.section, term: @secondary_course.term, title: @secondary_course.title, units: @secondary_course.units }
    assert_redirected_to secondary_course_path(assigns(:secondary_course))
  end

  test "should destroy secondary_course" do
    assert_difference('SecondaryCourse.count', -1) do
      delete :destroy, id: @secondary_course
    end

    assert_redirected_to secondary_courses_path
  end
end
