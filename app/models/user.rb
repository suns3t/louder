class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }

    def image_url_or_default
        return image_url if image_url else "http://loremflickr.com/60/60/#{name}"
    end

    def self.from_omniauth(auth)
        # Check out the Auth Hash function at https://github.com/mkdynamic/omniauth-facebook#auth-hash
        # and figure out how to get email for this user.
        # Note that Facebook sometimes does not return email,
        # in that case you can use facebook-id@facebook.com as a workaround
        email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
        user = where(email: email).first_or_initialize
        #
        # Set other properties on user here.
        # You may want to call user.save! to figure out why user can't save
        #
        # Finally, return user
        user.save! && user
    end
end
