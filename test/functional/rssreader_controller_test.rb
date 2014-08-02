require 'test_helper'

class RssreaderControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
