require "test_helper"

class MealTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get meal_types_index_url
    assert_response :success
  end

  test "should get create" do
    get meal_types_create_url
    assert_response :success
  end

  test "should get update" do
    get meal_types_update_url
    assert_response :success
  end

  test "should get destroy" do
    get meal_types_destroy_url
    assert_response :success
  end
end
