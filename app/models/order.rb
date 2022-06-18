# frozen_string_literal: true

class Order < ApplicationRecord
  serialize :reward_snapshot

  belongs_to :employee
  belongs_to :reward

  enum delivery_method: { Online: 'online', Post: 'post' }
end
