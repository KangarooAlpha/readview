class ImageContent < ApplicationRecord
  has_one :content, as: :contentable, dependent: :destroy

  has_many_attached :images
end
