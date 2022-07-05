# frozen_string_literal: true

class OnlineCode < ApplicationRecord
  validates :code, :reward, presence: true
  validates :code, uniqueness: true

  belongs_to :reward
  belongs_to :order, optional: true

  def sent?
    return true if order.present?

    false
  end
end
