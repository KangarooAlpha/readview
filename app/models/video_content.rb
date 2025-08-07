class VideoContent < ApplicationRecord
  has_one :content, as: :contenable, dependent: :destroy

  has_one_attached :video
end
