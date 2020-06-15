require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get movies_show_url
    assert_response :success
  end

  test "should get create" do
    get movies_create_url
    assert_response :success
  end

  test "should get index" do
    get movies_index_url
    assert_response :success
  end

  test "should get redirect" do
    get movies_redirect_url
    assert_response :success
  end

end
