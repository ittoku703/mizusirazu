class CommentsController < ApplicationController
  before_action :authenticate_user!

  # POST /comments
  def create
    @comment = current_user.comments.build(comment_params)

    @comment.save
    redirect_to @comment.micropost

    # respond_to do |format|
    #   format.html { redirect_to @comment.micropost }
    #   format.js
    # end
  end

  # PATCH /comment/:id
  def update
    @comment = Comment.find(params[:id])

    @comment.update(comment_params)
    redirect_to @comment.micropost

    # respond_to do |format|
    #   format.html { redirect_to @comment.micropost }
    #   format.js
    # end
  end

  # DELETE /comment/:id
  def destroy
    @comment = Comment.find(params[:id])

    @comment.destroy
    redirect_to @comment.micropost

    # respond_to do |format|
    #   format.html { redirect_to @comment.micropost }
    #   format.js
    # end
  end

  private

  def comment_params
    params.require(:comment).permit(:micropost_id, :content)
  end
end
