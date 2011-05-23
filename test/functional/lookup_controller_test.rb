require 'test_helper'

class LookupControllerTest < ActionController::TestCase
  test "should get addr" do
    get :addr
    assert_response :success
  end

  test "should get map" do
    get :map
    assert_response :success
  end

end
