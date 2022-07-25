# frozen_string_literal: true

class Order < ApplicationRecord
  serialize :reward_snapshot
  serialize :address_snapshot

  has_one :online_code, dependent: :destroy
  belongs_to :employee
  belongs_to :reward

  enum delivery_type: { post: 'post', pickup: 'pickup' }

  def type_and_address
    return 'Online' if reward_snapshot.online?
    return 'Pickup' if pickup?

    "Post, #{address_snapshot.street} #{address_snapshot.postcode} #{address_snapshot.city}"
  end
end
