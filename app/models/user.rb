class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :password_digest, presence: true

    has_many :friendships
    has_many :friend, through: :friendships
    paginates_per 2    

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
        
        user = where(email: email).first_or_initialize
        
        if user.id == nil

            # Set other properties on user here.
            user.name = auth[:info][:name]
            user.email = email
            user.password_digest = rand(100000..999999)

            # You may want to call user.save! to figure out why user can't save
            #
            # Finally, return user
            user.save!
        end
        return user
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
