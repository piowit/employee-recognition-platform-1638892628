# frozen_string_literal: true

class CompanyValue < ApplicationRecord
  validates :title, presence: true
end
