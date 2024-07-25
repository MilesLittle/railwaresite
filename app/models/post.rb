class Post < ApplicationRecord
  include PostImagesHandler
  belongs_to :user
  belongs_to :category
  has_many :post_images, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :cover_image


  validates :description, presence: true
  validates :cover_image, presence: true

  
 
end
