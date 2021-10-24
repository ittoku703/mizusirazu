# admin
admin = User.create!(email: 'admin@mizusirazu.net', password: 'password', password_confirmation: 'password')
admin.activate!
