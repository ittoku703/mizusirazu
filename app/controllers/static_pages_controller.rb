class StaticPagesController < ApplicationController
  before_action -> { valid_recaptcha('contact') }, only: %i[contact_post]
  before_action :contact_params_validation, only: %i[contact_post]

  def contact
  end

  def contact_post
    respond_to do |format|
      flash[:notice] = t('.success')
      StaticMailer.contact(contact_params).deliver_later
      format.html { redirect_to(root_path()) }
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:reply_email, :content)
  end

  def contact_params_validation
    reply_email = params[:contact][:reply_email]
    content = params[:contact][:content]

    if reply_email.length > 1000
      flash.now[:alert] = t('.reply_email_toolong')
      render(:contact, status: :unprocessable_entity) && return
    end

    if content.empty?
      flash.now[:alert] = t('.content_empty')
      render( :contact, status: :unprocessable_entity) && return
    elsif content.length > 10000
      flash.now[:alert] = t('.content_toolong')
      render( :contact, status: :unprocessable_entity) && return
    end
  end
end
