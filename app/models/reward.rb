# frozen_string_literal: true

class Reward < ApplicationRecord
  validates :price, numericality: { greater_than: 0 }
  validates :title, :description, :price, presence: true
  # has_one :employee, dependent: :destroy
end
