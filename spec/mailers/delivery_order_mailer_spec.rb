# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeliveryOrderMailer, type: :mailer do
  describe 'Delivery Order Confirmation' do
    let(:order) { create(:order) }
    let(:mail) { described_class.send_delivery_confirmation_email(order) }

    it 'checks receiver email' do
      expect(mail.to).to have_content order.employee.email
    end

    it 'checks title' do
      expect(mail.subject).to have_content order.reward_snapshot.title
    end

    it 'checks body content' do
      expect(mail.body).to have_content order.reward_snapshot.title
    end
  end
end
