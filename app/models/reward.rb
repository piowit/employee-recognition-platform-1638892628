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

  def self.import(file)
    ActiveRecord::Base.transaction do
      CSV.foreach(file.path, headers: true) do |row|
        reward_hash = row.to_hash
        if reward_hash['slug'].present?
          reward = Reward.find_or_initialize_by(slug: reward_hash['slug'])
          reward.slug = reward_hash['title'].parameterize
          reward.title = reward_hash['title']
          reward.description = reward_hash['description']
          reward.price = reward_hash['price'].to_f
          reward.delivery_method = reward_hash['delivery_method']
          reward.save!
        end
      end
    end
  end
end
