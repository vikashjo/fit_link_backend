require "test_helper"

class SettsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get setts_index_url
    assert_response :success
  end

  test "should get create" do
    get setts_create_url
    assert_response :success
  end
end
