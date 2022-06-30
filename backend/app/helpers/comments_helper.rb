module CommentsHelper
  def create_comment_submit(form, text, options = {})
    options[:class] = "p-2 border border-gray-400 text-black hover:text-white bg-emerald-400 hover:bg-emerald-500 rounded shadow #{options[:class]}"

    form.submit(text, options)
  end

  def update_comment_submit(form, text, options = {})
    options[:class] = "p-2 text-sm border border-gray-400 text-black hover:text-white bg-amber-400 hover:bg-amber-500 rounded shadow #{options[:class]}"

    form.submit(text, options)
  end

  def destroy_comment_link_to(text, link, options = {})
    options[:data] = { turbo_method: :delete, turbo_confirm: 'Are you sure?' }
    options[:class] = "p-2 text-sm border border-gray-400 text-black hover:text-white bg-rose-400 hover:bg-rose-500 rounded shadow hover:no-underline #{options[:class]}"

    link_to(text, link, options)
  end
end
