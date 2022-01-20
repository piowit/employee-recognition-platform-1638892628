# frozen_string_literal: true

class RewardsController < ApplicationController
  def index
    @rewards = Reward.all
  end

  def show
    @reward = Reward.find(params[:id])
  end
end
