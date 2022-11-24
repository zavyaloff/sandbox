require "test_helper"

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:homer)
    @micropost = microposts(:orange)
    @comment = @micropost.comments.build(content: "Just a comment", user_id: @user.id)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "user id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test "micropost id should be present" do
    @comment.micropost_id = nil
    assert_not @comment.valid?
  end

  test "comment should be present" do
    @comment.content = "   "
    assert_not @comment.valid?
  end

  test "content should be at most 150 characters" do
    @comment.content = "a" * 151
    assert_not @comment.valid?
  end

  test "order should be most recent first" do
    assert_equal comments(:most_recent), Comment.first
  end

end
