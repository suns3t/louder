class Message < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :recipient, class_name: 'User'

    scope :unread, -> { where(read_at: nil)}

    validates_presence_of :body, :sender_id, :recipient_id


    def mark_as_read!
        self.read_at = Time.now
        save!
        return "just now."
    end

    def read?
        read_at
    end

    def sender
        User.find(sender_id)
    end

    def recipient
        User.find(recipient_id)
    end
end
