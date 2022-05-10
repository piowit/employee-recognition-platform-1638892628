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
      if params[:file].nil?
        redirect_to admin_rewards_path, notice: 'No file selected.'
      elsif File.extname(params[:file]) != '.csv'
        redirect_to admin_rewards_path, notice: 'File is not a ".csv"'
      else
        Reward.import(params[:file])
        redirect_to admin_rewards_path, notice: 'Rewards imported.'
      end
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_rewards_path, notice: "Problem with CSV file. \"#{e}\""
    rescue CSV::MalformedCSVError => e
      redirect_to admin_rewards_path, notice: "Problem with CSV file. \"#{e}\""
    end

    private

    def reward_params
      params.require(:reward).permit(:title, :description, :price, :photo, category_ids: [])
    end
  end
end
