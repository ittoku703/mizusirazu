module ErrorHandle
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound,   with: :record_not_found

    def record_not_found(e)
      @exception = e
      render 'error_messages/record_not_found'
    end
  end
end