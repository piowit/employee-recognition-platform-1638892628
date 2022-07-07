# frozen_string_literal: true

class RewardSearch < Searchlight::Search
  def base_query
    Reward.all.in_stock.order(:title).with_attached_photo
  end

  def search_category
    category_id = Category.where(title: options.fetch(:category)).first&.id
    query.joins(:category_rewards).where(category_rewards: { category: category_id })
  end
end
