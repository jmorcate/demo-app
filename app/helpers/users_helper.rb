module UsersHelper
    def gravatar_for(user)
        user_id = Digest::MD5::hexdigest(user.email.downcase)
        user_url = "https://secure.gravatar.com/avatar/#{user_id}"
        image_tag(user_url, alt: user.name, class: "gravatar")
    end
end
