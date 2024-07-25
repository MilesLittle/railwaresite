class User < ApplicationRecord

   
    has_secure_password




    has_many :posts
    has_many :comments, dependent: :destroy
    has_one :inbox, dependent: :destroy

    after_create :create_inbox

    validates :username, presence: true, uniqueness: true

    def create_inbox
        Inbox.create(user: self)
    end

end
