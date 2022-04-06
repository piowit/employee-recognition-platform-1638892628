# frozen_string_literal: true

class Reward < ApplicationRecord
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :title, :description, :price, presence: true

  has_many :orders, dependent: :nullify
  has_many :category_rewards, dependent: :nullify
  has_many :categories, through: :category_rewards
end
