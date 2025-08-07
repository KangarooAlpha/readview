class TextContent < ApplicationRecord
  has_one :content, as: :contentable, dependent: :destroy

  validates :body, presence: true
end
