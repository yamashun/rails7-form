class ToDo < ApplicationRecord
  validates :title, presence: true
end
