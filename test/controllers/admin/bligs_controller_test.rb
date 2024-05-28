require "test_helper"

class Admin::BligsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_bligs_index_url
    assert_response :success
  end
end
