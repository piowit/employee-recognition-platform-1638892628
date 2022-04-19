# frozen_string_literal: true

class RewardSearch < Searchlight::Search
  def base_query
    Reward.all.order(:title).includes([photo_attachment: :blob])
    # include created as suggested here https://github.com/flyerhzm/bullet/issues/474
  end

  def search_category
    category_id = Category.where(title: options.fetch(:category)).first&.id
    query.joins(:category_rewards).where(category_rewards: { category: category_id })
  end
end
