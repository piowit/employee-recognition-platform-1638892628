# frozen_string_literal: true

class OnlineCode < ApplicationRecord
  belongs_to :reward
  belongs_to :order, optional: true

  validates :code, :reward, presence: true
  validates :code, uniqueness: true

  counter_culture :reward, column_name: proc { |online_code| online_code.sent? ? nil : 'online_codes_count' }

  scope :available, -> { where(order_id: nil) }

  def sent?
    order.present?
  end
end
