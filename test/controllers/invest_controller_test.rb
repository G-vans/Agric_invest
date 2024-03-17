require "test_helper"

class InvestControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get invest_index_url
    assert_response :success
  end

  test "should get success" do
    get invest_success_url
    assert_response :success
  end
end
