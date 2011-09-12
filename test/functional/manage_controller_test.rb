require 'test_helper'

class ManageControllerTest < ActionController::TestCase
  test "should get articles" do
    get :articles
    assert_response :success
  end

  test "should get pages" do
    get :pages
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get control" do
    get :control
    assert_response :success
  end

end
