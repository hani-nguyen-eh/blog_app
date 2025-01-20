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
    comment = current_user.comments.new(comment_params)

    if comment.save
      render json: { status: 'SUCCESS', message: 'Saved comment', data: comment }, status: :created
    else
      render json: { status: 'ERROR', message: 'Comment not saved', data: comment.errors }, status: :unprocessable_entity
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