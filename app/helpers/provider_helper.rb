module ProviderHelper
  def twitter_omniauth_button_to(options = {})
    options[:class] = "#{options[:class]} px-4 py-1 text-sky-500 border border-amber-500 bg-white rounded shadow hover:text-black hover:bg-sky-500"
    options[:data] = { turbo: false }

    button_to('/auth/twitter', options) do
      fa_icon('twitter')
    end
  end
end
