# frozen_string_literal: true

class Address < ApplicationRecord
  validates :employee_id, :street, :postcode, :city, presence: true

  belongs_to :employee
end
