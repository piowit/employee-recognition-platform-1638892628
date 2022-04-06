# frozen_string_literal: true

class RewardsController < ApplicationController
  before_action :authenticate_employee!

  REWARDS_PER_PAGE = 10

  def index
    page = params[:page].to_i || 0
    count_pages = (Reward.count / REWARDS_PER_PAGE) + 1
    rewards = Reward.limit(REWARDS_PER_PAGE).offset(page * REWARDS_PER_PAGE)
    render 'index', locals: { page: page, count_pages: count_pages, rewards: rewards }
  end

  def show
    @reward = Reward.find(params[:id])
  end
end
