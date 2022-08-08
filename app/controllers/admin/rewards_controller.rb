# frozen_string_literal: true

require 'csv'

module Admin
  class RewardsController < AdminController
    def index
      @rewards = Reward.all.with_attached_photo.order(:title)
    end

    def edit
      @reward = Reward.find(params[:id])
    end

    def new
      @reward = Reward.new
    end

    def create
      @reward = Reward.new(reward_params)
      @reward.slug = @reward.title.parameterize
      if @reward.save
        redirect_to admin_rewards_path, notice: 'Reward was successfully created.'
      else
        render :new
      end
    end

    def update
      @reward = Reward.find(params[:id])
      @reward.slug = reward_params[:title].parameterize
      if @reward.update(reward_params)
        redirect_to admin_rewards_path, notice: 'Reward was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @reward = Reward.find(params[:id])
      @reward.destroy
      redirect_to admin_rewards_path, notice: 'Reward was successfully destroyed.'
    end

    def export
      @rewards = Reward.all.order(:title)

      response.headers['Content-Type'] = 'text/csv'
      response.headers['Content-Disposition'] = "attachment; filename=rewards_#{Time.zone.now.strftime('%y%m%d_%H-%M-%S')}.csv"
      render template: 'admin/rewards/export', handlers: [:erb], formats: [:csv]
    end

    def import
      import_service = ImportRewardsCsvService.new(params)

      if import_service.call
        redirect_to admin_rewards_path, notice: 'Rewards imported.'
      else
        redirect_to admin_rewards_path, notice: import_service.errors.join(', ')
      end
    end

    private

    def reward_params
      params.require(:reward).permit(:title, :description, :price, :photo, :delivery_method, :available_items, category_ids: [])
    end
  end
end
