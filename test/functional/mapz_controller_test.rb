require 'test_helper'

class MapzControllerTest < ActionController::TestCase
  test "should get timecnn" do
    get :timecnn
    assert_response :success
  end

  test "should get timequery" do
    get :timequery
    assert_response :success
  end

end
