# frozen_string_literal: true

class Order < ApplicationRecord
  serialize :reward_snapshot
  serialize :address_snapshot

  has_one :online_code, dependent: :destroy
  belongs_to :employee
  belongs_to :reward

  def employee_name
    employee.full_name
  end
end
