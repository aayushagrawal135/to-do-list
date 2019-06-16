class Task < ApplicationRecord
  validates :title, allow_blank: false, presence: true
end
