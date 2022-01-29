# frozen_string_literal: true

require 'dry/monads'

class OrderCreator
  include Dry::Monads[:result, :do]

  def call(employee:, reward:)
    yield check_funds(employee, reward)
    Success('Reward bought')
  end

  private

  def check_funds(employee, reward)
    if employee.points < reward.price
      Failure('You have insufficient funds')
    else
      Success(create_order(employee, reward))
    end
  end

  def create_order(employee, reward)
    order = Order.new(employee: employee, reward: reward)
    if order.save
      Success()
    else
      Failure('Error')
    end
  end
end
