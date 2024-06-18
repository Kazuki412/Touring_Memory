require "test_helper"

class Admin::BlogCommentControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_blog_comment_index_url
    assert_response :success
  end
end
