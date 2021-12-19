class Kudo < ApplicationRecord
  validates :title, :content, :employee_id, :receiver_id, presence: true
  
  belongs_to :giver_of_kudo, class_name: "Employee", foreign_key: "employee_id"
  belongs_to :receiver_of_kudo, class_name: "Employee", foreign_key: "receiver_id"


  delegate :email, to: :giver_of_kudo, prefix: :giver #-> @kudo.giveremail
  delegate :email, to: :receiver_of_kudo, prefix: :receiver #-> @kudo.receiveremail
  
end
