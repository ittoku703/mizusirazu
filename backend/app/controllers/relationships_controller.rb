class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :activate_user
  before_action :set_relationship
  before_action -> { correct_relationship_user(@relationship) }, only: %i[destroy]

  # /relationships
  def create
    respond_to do |format|
      if @relationship.save
        flash[:notice] = t('.success')
        format.html { redirect_to(@relationship.followed, status: 302) }
      else
        flash[:alert] = t('.failed')
        format.html { redirect_to(current_user, status: 302) }
      end
    end
  end

  # /relationships/:id
  def destroy
    @relationship.destroy
    flash[:notice] = t('.success')
    redirect_to(@relationship.followed, status: 303)
  end

  private

  def relationship_params
    params.require(:relationship).permit(:followed_id)
  end

  def set_relationship
    case action_name
    when 'create'  then @relationship = current_user.active_relationships.build(relationship_params)
    when 'destroy' then @relationship = Relationship.eager_load(:follower, :followed).find(params[:id])
    end
  end

  def correct_relationship_user(relationship)
    unless current_user?(relationship.follower)
      flash[:alert] = t('you_are_not_current_user')
      redirect_to(root_path(), status: 302)
    end
  end
end
