class SessionsController < ApplicationController
  before_action :already_logged_in, only: %i[new create]
  before_action :valid_recaptcha, only: %i[create]

  # GET /signup
  def new
  end

  # POST /sessions
  def create
    @user = User.where(name: params[:session][:name_or_email]).or(User.where(email: params[:session][:name_or_email])).take
      respond_to do |format|
        if @user&.authenticate(params[:session][:password])
          if @user.activated?
            flash[:notice] = 'Successfully user was logged in'
            log_in @user
            params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
            format.html { redirect_back_or @user }
          else
            flash[:alert] = 'This user has not activated yet. Please user activate'
            format.html { redirect_to new_account_activation_path }
          end
        else
          flash.now[:alert] = 'Could not login. Please try again'
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

  # DELETE /logout
  def destroy
    log_out if logged_in?
    redirect_to(root_url, notice: 'successfully user was logged out', status: :see_other)
  end

  private
    def valid_recaptcha
      unless verify_recaptcha(action: 'login', minimum_score: 0.5)
        flash.now[:alert] = 'Score is below threshold, so user may be a bot'
        render(:new, status: :unprocessable_entity)
      end
    end
end
