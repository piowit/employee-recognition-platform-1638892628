# frozen_string_literal: true

class Reward < ApplicationRecord
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :title, :description, :price, presence: true
  validates :photo, file_content_type: { allow: ['image/jpeg', 'image/png'] }

  has_one_attached :photo

  has_many :orders, dependent: :nullify
  has_many :category_rewards, dependent: :destroy
  has_many :categories, through: :category_rewards

  def self.import(file)
    ActiveRecord::Base.transaction do
      CSV.foreach(file.path, headers: true) do |row|
        reward_hash = row.to_hash
        unless reward_hash['slug'].nil?
          reward = Reward.find_or_initialize_by(slug: reward_hash['slug'])
          reward.slug = reward_hash['title'].parameterize
          reward.title = reward_hash['title']
          reward.description = reward_hash['description']
          reward.price = reward_hash['price'].to_f
          reward.save!
        end
      end
    end
  end
end
