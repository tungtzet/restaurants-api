class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :name, :address, presence: true
end
