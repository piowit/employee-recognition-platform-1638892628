# frozen_string_literal: true

module Admin
  class RewardsController < AdminController
    def index
      @rewards = Reward.all
    end

    def edit
      @reward = Reward.find(params[:id])
    end

    def new
      @reward = Reward.new
    end

    def create
      @reward = Reward.new(reward_params)
      begin
        ActiveRecord::Base.transaction do
          @reward.update!(reward_params)
          @reward.categories.clear
          params[:reward][:category_ids]&.each do |category_id|
            @reward.categories << Category.find(category_id)
          end
          redirect_to admin_rewards_path, notice: 'Reward was successfully created.'
        end
      rescue ActiveRecord::RecordInvalid => e
        render :new, notice: e.message
      end
    end

    def update
      @reward = Reward.find(params[:id])
      begin
        ActiveRecord::Base.transaction do
          @reward.update!(reward_params)
          @reward.categories.clear
          params[:reward][:category_ids]&.each do |category_id|
            @reward.categories << Category.find(category_id)
          end
          redirect_to admin_rewards_path, notice: 'Reward was successfully updated.'
        end
      rescue ActiveRecord::RecordInvalid => e
        render :edit, notice: e.message
      end
    end

    def destroy
      @reward = Reward.find(params[:id])
      @reward.destroy
      redirect_to admin_rewards_path, notice: 'Reward was successfully destroyed.'
    end

    private

    def reward_params
      params.require(:reward).permit(:title, :description, :price, :category_ids)
    end
  end
end
