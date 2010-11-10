require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get integrate" do
    get :integrate
    assert_response :success
  end

  test "should get stats" do
    get :stats
    assert_response :success
  end

end
