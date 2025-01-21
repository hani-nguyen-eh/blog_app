class Api::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    comments = current_user.comments
    render json: { status: 'SUCCESS', message: 'Loaded comments', data: comments }, status: :ok
  end

  def show
    comment = current_user.comments.find_by(id: params[:id])

    if comment
      render json: { status: 'SUCCESS', message: 'Loaded comment', data: comment }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Comment not found' }, status: :not_found
    end
  end

  def create
    blog = current_user.blogs.find_by(id: params[:blog_id])
    if blog.nil?
      render json: { error: "Blog not found or you are not authorized to view it." }, status: :not_found
      return
    end
    comment = blog.comments.build(comment_params.merge(user_id: current_user.id))
    if comment.save
      render json: { data: comment }, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    comment = current_user.comments.find_by(id: params[:id])
    
    if comment
      if comment.update(comment_params)
        render json: { status: 'SUCCESS', message: 'Updated comment', data: comment }, status: :ok
      else
        render json: { status: 'ERROR', message: 'Comment not updated', data: comment.errors }, status: :unprocessable_entity
      end
    else
      render json: { status: 'ERROR', message: 'Comment not found' }, status: :not_found
    end

  end

  def destroy
    comment = current_user.comments.find_by(id: params[:id])

    if comment
      comment.destroy
      render json: { status: 'SUCCESS', message: 'Deleted comment', data: comment }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Comment not found' }, status: :not_found
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
  
end