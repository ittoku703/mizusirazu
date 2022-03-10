module ProviderHelper
  def twitter_omniauth_button_to(options = {})
    options[:class] = "#{options[:class]} px-4 py-1 text-sky-500 bg-white border border-amber-500 rounded shadow hover:text-black hover:bg-sky-500"
    options[:data] = { turbo: false }
    options[:alt] = :twitter

    button_to('/auth/twitter', options) do
      fa_icon('twitter')
    end
  end

  def github_omniauth_button_to(options = {})
    options[:class] = "#{options[:class]} px-4 py-1 text-black bg-white border border-emerald-500 rounded shadow hover:text-white hover:bg-gray-700"
    options[:data] = { turbo: false }
    options[:alt] = :github

    button_to('/auth/github', options) do
      fa_icon('github')
    end
  end
end
