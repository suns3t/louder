class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }

    def image_url_or_default
        return image_url if image_url else "http://loremflickr.com/60/60/#{name}"
    end
end
