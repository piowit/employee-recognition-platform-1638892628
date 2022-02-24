# frozen_string_literal: true

class OrderSearch < Searchlight::Search
  def base_query
    Order.all
  end

  def search_delivered
    query.where(delivered: options.fetch(:delivered))
  end
end
