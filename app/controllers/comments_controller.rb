class CommentsController < ApplicationController
  before_action :authenticate_user!

  # POST /microposts/:micropost_id/comments
  def create
    @comment = current_user.comments.build(comment_params)

    @comment.save
    respond_to_ajax
  end

  # PATCH /micropost/:micropost_id/comment/:id
  def update
    @comment = Comment.find(params[:id])

    @comment.update(comment_params)
    respond_to_ajax
  end

  # DELETE /micropost/:micropost_id/comment/:id
  def destroy
    @comment = Comment.find(params[:id])

    @comment.destroy
    respond_to_ajax
  end

  private

  def respond_to_ajax
    respond_to do |format|
      format.html { redirect_to @comment.micropost }
      format.js
    end
  end

  def comment_params
    params.require(:comment).permit(:micropost_id, :content, images: [])
  end
end
