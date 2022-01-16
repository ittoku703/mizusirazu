class SessionsController < ApplicationController
  # GET /signup
  def new
  end

  # POST /sessions
  def create
    @user = User.where(name: params[:session][:name_or_email]).or(User.where(email: params[:session][:name_or_email])).take
    respond_to do |format|
      if @user&.authenticate(params[:session][:password])
        log_in @user
        format.html { redirect_back_or(@user, notice: 'successfully user was logged in') }
      else
        flash.now[:alert] = 'Could not login. Please try again'
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logout
  def destroy
    log_out if logged_in?
    redirect_to root_url, notice: 'successfully user was logged out'
  end

  private
    def session_params
      params.require(:session).permit(:name_or_email, :password)
    end
end
