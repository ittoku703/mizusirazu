class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :activate_user
  before_action :set_comment
  before_action -> { correct_comment_user(@comment) }, only: %i[update destroy]

  def create
    respond_to do |format|
      if @comment.save
        flash[:notice] = t('.success')
        format.html { redirect_to(micropost_path(params[:micropost_id]), status: :found) }
      else
        flash[:alert] = t('.failed')
        format.html { redirect_to(micropost_path(params[:micropost_id]), status: :found) }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        flash[:notice] = t('.success')
        format.html { redirect_to(micropost_path(params[:micropost_id]), status: :found) }
      else
        flash[:alert] = t('.failed')
        format.html { redirect_to(micropost_path(params[:micropost_id]), status: :found) }
      end
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = t('.success')
    redirect_to(micropost_path(params[:micropost_id]), status: :see_other)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :micropost_id)
  end

  def set_comment
    case action_name
    when 'create'  then @comment = current_user.comments.new(comment_params)
    when 'update'  then @comment = Comment.find(params[:id])
    when 'destroy' then @comment = Comment.find(params[:id])
    end
  end

  def correct_comment_user(comment)
    unless current_user?(comment.user)
      flash[:alert] = t('you_are_not_current_user')
      redirect_to(root_url(), status: :see_other)
    end
  end
end
