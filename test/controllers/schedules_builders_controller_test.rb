require 'test_helper'

class SchedulesBuildersControllerTest < ActionController::TestCase
  setup do
    @schedules_builder = schedules_builders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schedules_builders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create schedules_builder" do
    assert_difference('SchedulesBuilder.count') do
      post :create, schedules_builder: { classes: @schedules_builder.classes }
    end

    assert_redirected_to schedules_builder_path(assigns(:schedules_builder))
  end

  test "should show schedules_builder" do
    get :show, id: @schedules_builder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @schedules_builder
    assert_response :success
  end

  test "should update schedules_builder" do
    patch :update, id: @schedules_builder, schedules_builder: { classes: @schedules_builder.classes }
    assert_redirected_to schedules_builder_path(assigns(:schedules_builder))
  end

  test "should destroy schedules_builder" do
    assert_difference('SchedulesBuilder.count', -1) do
      delete :destroy, id: @schedules_builder
    end

    assert_redirected_to schedules_builders_path
  end
end
