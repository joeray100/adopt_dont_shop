class Application < ApplicationRecord
  has_many :pet_applications, dependent: :destroy
  has_many :pets, through: :pet_applications

  enum status: [:"in_progress", :"pending", :"approved", :"rejected"]

  validates :name, :address, :city, :state, :description, :status, presence: true
  validates :zip, presence: true, numericality: true
end
