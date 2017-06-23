require 'test_helper'

class BuildSchedulesControllerTest < ActionController::TestCase
  setup do
    @build_schedule = build_schedules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:build_schedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create build_schedule" do
    assert_difference('BuildSchedule.count') do
      post :create, build_schedule: { courses: @build_schedule.courses }
    end

    assert_redirected_to build_schedule_path(assigns(:build_schedule))
  end

  test "should show build_schedule" do
    get :show, id: @build_schedule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @build_schedule
    assert_response :success
  end

  test "should update build_schedule" do
    patch :update, id: @build_schedule, build_schedule: { courses: @build_schedule.courses }
    assert_redirected_to build_schedule_path(assigns(:build_schedule))
  end

  test "should destroy build_schedule" do
    assert_difference('BuildSchedule.count', -1) do
      delete :destroy, id: @build_schedule
    end

    assert_redirected_to build_schedules_path
  end
end
