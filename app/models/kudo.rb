# frozen_string_literal: true

class Kudo < ApplicationRecord
  validates :title, :content, :employee_id, :receiver_id, :company_value_id, presence: true

  belongs_to :giver_of_kudo, class_name: 'Employee', foreign_key: 'employee_id', inverse_of: :given_kudos
  belongs_to :receiver_of_kudo, class_name: 'Employee', foreign_key: 'receiver_id', inverse_of: :received_kudos
  belongs_to :company_value, class_name: 'CompanyValue'
end
