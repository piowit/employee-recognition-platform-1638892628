# frozen_string_literal: true

class Employee < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :given_kudos, class_name: 'Kudo', foreign_key: 'giver_id', dependent: :destroy, inverse_of: :giver
  has_many :received_kudos, class_name: 'Kudo', foreign_key: 'receiver_id', dependent: :destroy, inverse_of: :receiver
  has_many :orders, dependent: :destroy
  has_many :rewards, through: :orders
  has_many :addresses, dependent: :destroy

  validates :first_name, :last_name, presence: true

  def points
    received_kudos.count - rewards.sum(:price).to_i
  end

  def full_name
    if first_name && last_name
      "#{first_name} #{last_name}"
    else
      email
    end
  end
end
