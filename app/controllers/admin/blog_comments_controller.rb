class Admin::BlogCommentsController < ApplicationController

  def index
    @blog_comments = BlogComment.all
  end

  def destroy
    BlogComment.find(params[:id]).destroy
    redirect_to admin_blog_comments_path
  end
end
