# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateOrderService do
  let!(:employee) { create(:employee) }

  context 'when buying postal reward' do
    let!(:reward_post) { create(:reward, price: 1, delivery_method: 'post', available_items: 100) }

    before do
      create(:kudo, receiver: employee) # add funds
    end

    context 'when all attributes are present' do
      it 'is valid' do
        params = { address: attributes_for(:address), reward_id: reward_post.id }
        create_order_service = described_class.new(params, employee)
        expect(create_order_service.call).to be true
      end

      it 'adds new order to db and new address' do
        params = { address: attributes_for(:address), reward_id: reward_post.id }
        create_order_service = described_class.new(params, employee)
        expect { create_order_service.call }.to change { Order.all.count }.by(1)
      end

      it 'adds new order new address to db' do
        params = { address: attributes_for(:address), reward_id: reward_post.id }
        create_order_service = described_class.new(params, employee)
        expect { create_order_service.call }.to change { Address.all.count }.by(1)
      end

      it 'adds changes existing address' do
        create(:address, employee: employee)
        params = { address: attributes_for(:address), reward_id: reward_post.id }
        create_order_service = described_class.new(params, employee)
        expect { create_order_service.call }.not_to change { Address.all.count }
      end

      it 'delivers confirmation email' do
        params = { address: attributes_for(:address), reward_id: reward_post.id }
        create_order_service = described_class.new(params, employee)
        expect { create_order_service.call }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context 'when attributes are missing' do
      it 'is invalid without street' do
        params = { address: attributes_for(:address, street: nil), reward_id: reward_post.id }
        create_order_service = described_class.new(params, employee)
        expect(create_order_service.call).to be false
        expect(create_order_service.errors.to_s).to include "Street can't be blank"
      end

      it 'is invalid without postcode' do
        params = { address: attributes_for(:address, postcode: nil), reward_id: reward_post.id }
        create_order_service = described_class.new(params, employee)
        expect(create_order_service.call).to be false
        expect(create_order_service.errors.to_s).to include "Postcode can't be blank"
      end

      it 'is invalid without city' do
        params = { address: attributes_for(:address, city: nil), reward_id: reward_post.id }
        create_order_service = described_class.new(params, employee)
        expect(create_order_service.call).to be false
        expect(create_order_service.errors.to_s).to include "City can't be blank"
      end
    end

    it 'is invalid when not enough funds' do
      reward_post_price = create(:reward, price: 10, delivery_method: 'post', available_items: 1)
      params = { address: attributes_for(:address), reward_id: reward_post_price.id }
      create_order_service = described_class.new(params, employee)
      expect(create_order_service.call).to be false
      expect(create_order_service.errors.to_s).to include 'You have insufficient funds'
    end

    it 'is invalid when not enough items in stock' do
      reward_post_stock = create(:reward, price: 1, delivery_method: 'post', available_items: 0)
      params = { address: attributes_for(:address), reward_id: reward_post_stock.id }
      create_order_service = described_class.new(params, employee)
      expect(create_order_service.call).to be false
      expect(create_order_service.errors.to_s).to include 'Not enough items in stock'
    end
  end

  context 'when buying online reward' do
    let!(:reward_online) { create(:reward, price: 1, delivery_method: 'online') }

    before do
      create(:kudo, receiver: employee) # add funds
      create(:online_code, reward: reward_online)
    end

    context 'when all attributes are present' do
      it 'is valid' do
        params = { employee: employee, reward_id: reward_online.id }
        create_order_service = described_class.new(params, employee)
        expect(create_order_service.call).to be true
      end

      it 'adds new order to db' do
        params = { employee: employee, reward_id: reward_online.id }
        create_order_service = described_class.new(params, employee)
        expect { create_order_service.call }.to change { Order.all.count }.by(1)
      end

      it 'delivers online code' do
        params = { employee: employee, reward_id: reward_online.id }
        create_order_service = described_class.new(params, employee)
        expect { create_order_service.call }.to change { ActionMailer::Base.deliveries.count }.by(1)
        expect(Order.last.delivered).to eq(true)
        expect(ActionMailer::Base.deliveries.last.body.to_s).to include OnlineCode.first.code
      end
    end

    it 'is invalid when not enough online_codes' do
      params = { employee: employee, reward_id: reward_online.id }
      orders_count_before = Order.all.count

      create_order_service = described_class.new(params, employee)
      expect(create_order_service.call).to be true # buy first code
      expect(create_order_service.call).to be false # buy second code, but there was only one

      expect(Order.all.count).to eq(orders_count_before + 1)
    end

    it 'is invalid when not enough funds' do
      reward_online_price = create(:reward, price: 10, delivery_method: 'online')
      create(:online_code, reward: reward_online_price)
      params = { address: attributes_for(:address), reward_id: reward_online_price.id }
      create_order_service = described_class.new(params, employee)
      expect(create_order_service.call).to be false
      expect(create_order_service.errors.to_s).to include 'You have insufficient funds'
    end
  end
end
