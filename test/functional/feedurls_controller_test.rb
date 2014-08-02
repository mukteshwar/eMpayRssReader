require 'test_helper'

class FeedurlsControllerTest < ActionController::TestCase
  setup do
    @feedurl = feedurls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:feedurls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create feedurl" do
    assert_difference('Feedurl.count') do
      post :create, feedurl: { feed_title: @feedurl.feed_title, feed_url: @feedurl.feed_url }
    end

    assert_redirected_to feedurl_path(assigns(:feedurl))
  end

  test "should show feedurl" do
    get :show, id: @feedurl
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @feedurl
    assert_response :success
  end

  test "should update feedurl" do
    put :update, id: @feedurl, feedurl: { feed_title: @feedurl.feed_title, feed_url: @feedurl.feed_url }
    assert_redirected_to feedurl_path(assigns(:feedurl))
  end

  test "should destroy feedurl" do
    assert_difference('Feedurl.count', -1) do
      delete :destroy, id: @feedurl
    end

    assert_redirected_to feedurls_path
  end
end
