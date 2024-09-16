require "test_helper"

class OnlineFileControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get online_file_index_url
    assert_response :success
  end

  test "should get show" do
    get online_file_show_url
    assert_response :success
  end

  test "should get create" do
    get online_file_create_url
    assert_response :success
  end
end
