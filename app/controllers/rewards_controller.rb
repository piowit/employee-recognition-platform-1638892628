# frozen_string_literal: true

class RewardsController < ApplicationController
  before_action :authenticate_employee!

  REWARDS_PER_PAGE = 2

  def index
    @page = 1
    @rewards = Reward.limit(REWARDS_PER_PAGE).offset(@page * REWARDS_PER_PAGE)
  end

  def show
    @reward = Reward.find(params[:id])
  end
end
