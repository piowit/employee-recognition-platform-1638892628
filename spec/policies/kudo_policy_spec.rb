# frozen_string_literal: true

require 'rails_helper'

RSpec.describe KudoPolicy do
  subject { described_class }

  let(:employee) { create(:employee) }
  let(:employee_wrong) { create(:employee) }
  let(:kudo) { create(:kudo, giver: employee) }

  permissions :edit?, :update? do
    it 'grants access if good employee and edit time less then 5 minutes' do
      expect(subject).to permit(employee, kudo)
    end

    it 'denies access if wrong employee' do
      expect(subject).not_to permit(employee_wrong, kudo)
    end

    it 'denies access if post is over 5 minute old' do
      kudo_old = create(:kudo, giver: employee)
      travel 6.minutes do
        expect(subject).not_to permit(employee, kudo_old)
      end
    end
  end
end
