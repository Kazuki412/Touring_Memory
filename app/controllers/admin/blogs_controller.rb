class Admin::BlogsController < ApplicationController

  def index
    @blogs = Blog.order("id desc")
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def destroy
    Blog.find(params[:id]).destroy
    redirect_to admin_blogs_path
  end
end
