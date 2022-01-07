module UsersHelper
  def user_destroy_link(user)
    link_to 'Delete', user, data: { turbo_method: :delete, turbo_confirm: 'Are you sure?' }
  end
end
