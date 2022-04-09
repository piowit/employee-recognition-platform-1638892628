# frozen_string_literal: true

class Category < ApplicationRecord
  validates :title, presence: true

  has_many :category_rewards, dependent: :destroy
  has_many :rewards, through: :category_rewards
end
