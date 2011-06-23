require 'test_helper'

class ValidatorControllerTest < ActionController::TestCase
  test "should get val" do
    get :val
    assert_response :success
  end

  test "should get enter" do
    get :enter
    assert_response :success
  end

end
