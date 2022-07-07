# frozen_string_literal: true

class OnlineCode < ApplicationRecord
  validates :code, :reward, presence: true
  validates :code, uniqueness: true

  belongs_to :reward
  counter_culture :reward, column_name: proc { |model| model.sent? ? nil : 'online_codes_count' }

  belongs_to :order, optional: true

  scope :available, -> { where(order_id: nil) }

  def sent?
    order.present?
  end

  def self.import(file)
    ActiveRecord::Base.transaction do
      CSV.foreach(file.path, headers: true) do |row|
        online_code_hash = row.to_hash
        next if online_code_hash['slug'].nil?
        next if OnlineCode.where(code: online_code_hash['code']).present?
        next if Reward.where(slug: online_code_hash['slug']).nil?

        reward = Reward.where(slug: online_code_hash['slug']).first
        online_code = OnlineCode.new(code: online_code_hash['code'], reward_id: reward.id)
        online_code.save!
      end
    end
  end
end
