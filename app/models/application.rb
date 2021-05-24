class Application < ApplicationRecord
  has_many :pet_applications, dependent: :destroy
  has_many :pets, through: :pet_applications

  enum status: {"In Progress": 0, "Pending": 1, "Approved": 2, "Rejected": 3}

  validates :name, :address, :city, :state, :description, :status, presence: true
  validates :zip, presence: true, numericality: true

  def adopted_pets(pet)
    pets << pet
  end

  def pet_count
    pets.count
  end
end
