class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :inbox, optional: true
 

  validates :body, presence: true
end
