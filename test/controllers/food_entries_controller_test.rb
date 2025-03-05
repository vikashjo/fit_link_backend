require "test_helper"

class FoodEntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get food_entries_create_url
    assert_response :success
  end

  test "should get destory" do
    get food_entries_destory_url
    assert_response :success
  end
end
