class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }

    has_many :friendships
    has_many :friend, through: :friendships
    

    def image_url_or_default
        return image_url if image_url else "http://loremflickr.com/60/60/#{name}"
    end

    def to_string
        return "#{name} - #{email}"
    end
    
    def self.from_omniauth(auth)
        # Check out the Auth Hash function at https://github.com/mkdynamic/omniauth-facebook#auth-hash
        # and figure out how to get email for this user.
        # Note that Facebook sometimes does not return email,
        # in that case you can use facebook-id@facebook.com as a workaround
        email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
        name = auth[:info][:name]
        user = where(email: email).first_or_initialize
        #
        # Set other properties on user here.
        # You may want to call user.save! to figure out why user can't save
        #
        # Finally, return user
        user.save! && user
    end

    def received_messages
        where(recipient: self)
    end

    def sent_messages
        where(sender: self)
    end

    def latest_received_messages(n)
        received_messages.order(created_at: :desc).limit(n)
    end

    def unread_messages
        received_messages.unread
    end
end
