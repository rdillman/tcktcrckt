require 'test_helper'

class AlertControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get kill" do
    get :kill
    assert_response :success
  end

end
