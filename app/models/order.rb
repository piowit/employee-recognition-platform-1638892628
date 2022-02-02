# frozen_string_literal: true

class Order < ApplicationRecord
  serialize :snapshot, Reward

  belongs_to :employee
  belongs_to :reward
end
