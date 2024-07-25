class PostImage < ApplicationRecord
  has_one_attached :image
  belongs_to :post, optional: true
end
