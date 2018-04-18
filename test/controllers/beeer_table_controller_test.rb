require 'test_helper'

class BeeerTableControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
