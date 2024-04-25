require "test_helper"

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tickets_index_url
    assert_response :success
  end

  test "should get update" do
    get tickets_update_url
    assert_response :success
  end

  test "should get show" do
    get tickets_show_url
    assert_response :success
  end

  test "should get cost" do
    get tickets_cost_url
    assert_response :success
  end
end
