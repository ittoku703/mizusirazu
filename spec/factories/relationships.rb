FactoryBot.define do
  factory :relationship do
    followed_id { create(:user).id }
    follower_id { create(:other_user).id }
  end
end
