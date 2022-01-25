# frozen_string_literal: true

class Kudo < ApplicationRecord
  validates :title, :content, :giver_id, :receiver_id, :company_value_id, presence: true

  belongs_to :giver, class_name: 'Employee', inverse_of: :given_kudos
  belongs_to :receiver, class_name: 'Employee', inverse_of: :received_kudos
  belongs_to :company_value, class_name: 'CompanyValue'
end
