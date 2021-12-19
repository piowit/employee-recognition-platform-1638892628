# frozen_string_literal: true

class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :given_kudos, class_name: "Kudo", foreign_key: "employee_id"
  has_many :received_kudos, class_name: "Kudo", foreign_key: "receiver_id"
end
