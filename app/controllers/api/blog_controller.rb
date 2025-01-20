class Api::BlogsController < ApplicationController
  skip_before_action :authenverify_authenticity_token
  before_action :authenticate_user!

  def index
    blog = current_user.blogs
    render json: { status: 'SUCCESS', message: 'Loaded blogs', data: blog }, status: :ok
  end

  def show
    @post = current_user.blogs.find_by(id: params[:id])

    if blog
      render json: { status: 'SUCCESS', message: 'Loaded blog', data: blog }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Blog not found' }, status: :not_found
    end
  end

  def create
    blog = current_user.blogs.new(blog_params)

    if blog.save
      render json: { status: 'SUCCESS', message: 'Saved blog', data: blog }, status: :created
    else
      render json: { status: 'ERROR', message: 'Blog not saved', data: blog.errors }, status: :unprocessable_entity
    end
  end

  def update
    blog = current_user.blogs.find_by(id: params[:id])

    if blog
      if blog.update(blog_params)
        render json: { status: 'SUCCESS', message: 'Updated blog', data: blog }, status: :ok
      else
        render json: { status: 'ERROR', message: 'Blog not updated', data: blog.errors }, status: :unprocessable_entity
      end
    else
      render json: { status: 'ERROR', message: 'Blog not found' }, status: :not_found
    end

    def destroy
      blog = current_user.blogs.find_by(id: params[:id])

      if blog
        blog.destroy
        render json: { status: 'SUCCESS', message: 'Deleted blog', data: blog }, status: :ok
      else
        render json: { status: 'ERROR', message: 'Blog not found' }, status: :not_found
      end
    end

    end

    private
    def blog_params
      params.require(:blog).permit(:title, :content)
    end
end