class Kudo < ApplicationRecord
  validates :title, :content, :employee, presence: true
  
  belongs_to :employee
end
