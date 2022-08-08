# frozen_string_literal: true

class Reward < ApplicationRecord
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :title, :description, :price, presence: true
  validates :photo, file_content_type: { allow: ['image/jpeg', 'image/png'] }

  has_one_attached :photo

  has_many :orders, dependent: :nullify
  has_many :online_codes, dependent: :destroy
  has_many :category_rewards, dependent: :destroy
  has_many :categories, through: :category_rewards

  enum delivery_method: { online: 'online', post: 'post' }

  scope :in_stock, -> { where('available_items > 0').or(where('online_codes_count > 0')) }

  def number_of_available_items
    delivery_method == 'online' ? online_codes_count : available_items
  end
end
