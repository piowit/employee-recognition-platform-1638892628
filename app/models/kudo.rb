# frozen_string_literal: true

class Kudo < ApplicationRecord
  validates :title, :content, :employee_id, :receiver_id, :company_value_id, presence: true
  after_create :add_point

  belongs_to :giver_of_kudo, class_name: 'Employee', foreign_key: 'employee_id', inverse_of: :given_kudos
  belongs_to :receiver_of_kudo, class_name: 'Employee', foreign_key: 'receiver_id', inverse_of: :received_kudos
  belongs_to :company_value, class_name: 'CompanyValue'

  def add_point
    receiver_of_kudo.points += 1
    receiver_of_kudo.save
  end
end
