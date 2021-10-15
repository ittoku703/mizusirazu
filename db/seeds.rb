# admin
user=User.create!(Rails.application.credentials.admin_user)
user.activate!

