class Public::BlogsController < ApplicationController
  before_action :check_block, only: [:show]
  
  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    @blog.save
    redirect_to blogs_path
  end
  
  def index
    # visible_toの解説はブログモデルに記載
    @blogs = Blog.visible_to(current_user)
  end

  def show
    @blog = Blog.find(params[:id])
    @blog_comment = BlogComment.new
    @blog_comments = @blog.blog_comments.reject { |comment| blocked_comment_user?(comment.user) }
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    blog = Blog.find(params[:id])
    blog.update(blog_params)
    redirect_to blog_path(blog.id)
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy
    redirect_to blogs_path
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :body)
  end

  # ブロックされている場合、トップページへ
  def check_block
    @blog = Blog.find(params[:id])
    if current_user.blocked_by?(@blog.user)
      redirect_to root_path, alert: "アクセスできません"
    end
  end

  # ブロックしているユーザー、もしくはブロックされているユーザーにコメントはそのユーザーには非表示に
  def blocked_comment_user?(user)
    current_user.blocking?(user) || current_user.blocked_by?(user)
  end

end
