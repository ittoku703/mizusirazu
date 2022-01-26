class AccountActivationsController < ApplicationController
  before_action :already_activated
  before_action -> { set_user(email: params[:email]) }, only: %i[edit]

  # GET /confirms/new
  def new
  end

  # POST /confirms
  def create
    respond_to do |format|
      if verify_recaptcha(action: 'account_activation', minimum_score: 0.5)
        if @user = User.find_by(email: params[:account_activation][:email])
          unless @user.activated?
            @user.create_activation_digest; @user.send_activation_email;
            format.html { redirect_to(root_path, notice: 'Send account activation email, Please check email and activate your account') }
          else
            format.html { redirect_to(root_path, notice: 'User already activated') }
          end
        else
          flash.now[:alert] = 'Email is invalid, Please try again'
          format.html { render :new, status: :unprocessable_entity }
        end
      else
        flash.now[:alert] = 'Score is below threshold, so user may be a bot'
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # GET /confirms/:id/edit
  def edit
    respond_to do |format|
      if @user&.authenticated?(:activation, params[:id])
        unless @user.activated?
          @user.activate; log_in(@user);
          format.html { redirect_to(root_path, notice: 'Successfully user was activated') }
        else
          format.html { redirect_to(root_path, notice: 'User already activated') }
        end
      else
        format.html { redirect_to(new_account_activation_path, alert: 'User activation is failed') }
      end
    end
  end

  private
    # return true if user is activated
    def account_activated?
      current_user&.activated?
    end

    # redirect to root if user activated
    def already_activated
      redirect_to(root_path, notice: 'User already activated') if account_activated?
    end
end
