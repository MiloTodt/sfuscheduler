require 'test_helper'

class ScheduleBuildersControllerTest < ActionController::TestCase
  setup do
    @schedule_builder = schedule_builders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schedule_builders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create schedule_builder" do
    assert_difference('ScheduleBuilder.count') do
      post :create, schedule_builder: {  }
    end

    assert_redirected_to schedule_builder_path(assigns(:schedule_builder))
  end

  test "should show schedule_builder" do
    get :show, id: @schedule_builder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @schedule_builder
    assert_response :success
  end

  test "should update schedule_builder" do
    patch :update, id: @schedule_builder, schedule_builder: {  }
    assert_redirected_to schedule_builder_path(assigns(:schedule_builder))
  end

  test "should destroy schedule_builder" do
    assert_difference('ScheduleBuilder.count', -1) do
      delete :destroy, id: @schedule_builder
    end

    assert_redirected_to schedule_builders_path
  end
end
