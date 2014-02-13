module UsersHelper

  def gravatar_for(user, options = {})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar#{' ' + options[:class] if options[:class]}", size: options[:size])
  end
end
