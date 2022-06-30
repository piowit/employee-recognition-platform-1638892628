class Address < ApplicationRecord
  validates :employee_id, :street, :postcode, :city, presence: true

  belongs_to :employee

  def full_address
    "#{street}, #{postcode}, #{city}"
  end
end
