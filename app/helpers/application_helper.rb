module ApplicationHelper
  def gravatar_for(user, options = {size: 200})
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, class: "avatar rounded-circle", alt: user.username)
  end
end
