# frozen_string_literal: true

class ImportRewardsCsvService
  attr_reader :errors

  def initialize(params)
    @file = params[:file]
    @errors = []
  end

  def call
    return false unless file_format_csv?

    ActiveRecord::Base.transaction do
      import_csv
    end

    true
  rescue ActiveRecord::StatementInvalid, ActiveRecord::RecordInvalid, CSV::MalformedCSVError => e
    @errors << e.message
    false
  end

  private

  def file_format_csv?
    if @file.nil?
      @errors << 'No file selected.'
      return false
    elsif File.extname(@file) != '.csv'
      @errors << 'File is not a ".csv"'
      return false
    end

    true
  end

  def import_csv
    CSV.foreach(@file, headers: true) do |row|
      reward_hash = row.to_hash
      if reward_hash['slug'].present?
        reward = Reward.find_or_initialize_by(slug: reward_hash['slug'])
        reward.slug = reward_hash['title'].parameterize
        reward.title = reward_hash['title']
        reward.description = reward_hash['description']
        reward.price = reward_hash['price'].to_f
        reward.delivery_method = reward_hash['delivery_method']
        reward.save!
      end
    end
  end
end
