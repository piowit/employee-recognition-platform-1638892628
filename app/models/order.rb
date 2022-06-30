# frozen_string_literal: true

class Order < ApplicationRecord
  serialize :reward_snapshot
  serialize :address_snapshot

  belongs_to :employee
  belongs_to :reward
end
