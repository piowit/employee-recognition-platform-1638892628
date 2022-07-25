# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeliveryOrderMailer, type: :mailer do
  describe 'Delivery Order Confirmation' do
    context 'when delivering post order' do
      it 'sends email to proper receiver' do
        order = create(:order)
        mail_delivery = DeliveryOrderMailer.with(order: order).delivery_confirmation_email
        expect(mail_delivery.to).to have_content order.employee.email
      end

      it 'send email with correct title' do
        order = create(:order)
        mail_delivery = DeliveryOrderMailer.with(order: order).delivery_confirmation_email
        expect(mail_delivery.subject).to have_content order.reward_snapshot.title
      end

      it 'send email with correct body' do
        order = create(:order)
        mail_delivery = DeliveryOrderMailer.with(order: order).delivery_confirmation_email
        expect(mail_delivery.body).to have_content order.reward_snapshot.title
      end
    end

    context 'when buying pickup order' do
      it 'sends email to proper receiver' do
        order = create(:order)
        mail_delivery = DeliveryOrderMailer.with(order: order).pickup_delivery_email
        expect(mail_delivery.to).to have_content order.employee.email
      end

      it 'send email with correct title' do
        order = create(:order)
        mail_delivery = DeliveryOrderMailer.with(order: order).pickup_delivery_email
        expect(mail_delivery.subject).to have_content order.reward_snapshot.title
      end

      it 'send email with correct body' do
        order = create(:order)
        mail_delivery = DeliveryOrderMailer.with(order: order).pickup_delivery_email
        expect(mail_delivery.body).to have_content order.reward_snapshot.title
      end
    end

    context 'when buying online_code order' do
      it 'sends email to proper receiver' do
        online_code = create(:online_code)
        order = create(:order)
        mail_delivery = DeliveryOrderMailer.with(order: order, code: online_code.code).online_code_delivery_email
        expect(mail_delivery.to).to have_content order.employee.email
      end

      it 'send email with correct title' do
        online_code = create(:online_code)
        order = create(:order)
        mail_delivery = DeliveryOrderMailer.with(order: order, code: online_code.code).online_code_delivery_email
        expect(mail_delivery.subject).to have_content order.reward_snapshot.title
      end

      it 'send email with online_code in body' do
        online_code = create(:online_code)
        order = create(:order)
        mail_delivery = DeliveryOrderMailer.with(order: order, code: online_code.code).online_code_delivery_email
        expect(mail_delivery.body).to have_content online_code.code
      end
    end
  end
end
