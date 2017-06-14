require 'test_helper'

class ClasstimesControllerTest < ActionController::TestCase
  setup do
    @classtime = classtimes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:classtimes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create classtime" do
    assert_difference('Classtime.count') do
      post :create, classtime: { name: @classtime.name, start_time: @classtime.start_time }
    end

    assert_redirected_to classtime_path(assigns(:classtime))
  end

  test "should show classtime" do
    get :show, id: @classtime
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @classtime
    assert_response :success
  end

  test "should update classtime" do
    patch :update, id: @classtime, classtime: { name: @classtime.name, start_time: @classtime.start_time }
    assert_redirected_to classtime_path(assigns(:classtime))
  end

  test "should destroy classtime" do
    assert_difference('Classtime.count', -1) do
      delete :destroy, id: @classtime
    end

    assert_redirected_to classtimes_path
  end
end
