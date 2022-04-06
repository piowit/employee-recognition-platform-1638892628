# frozen_string_literal: true

class CategoryReward < ApplicationRecord
  belongs_to :category
  belongs_to :reward
end
