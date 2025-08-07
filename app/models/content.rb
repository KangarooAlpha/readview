class Content < ApplicationRecord
  belongs_to :postable, polymorphic: true
  belongs_to :contentable, polymorphic: true
end
