# frozen_string_literal: true

class ImportOnlineCodesCsvService
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
  rescue ActiveRecord::StatementInvalid, ActiveRecord::RecordInvalid => e
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
      online_code_hash = row.to_hash
      next if online_code_hash['slug'].nil?
      next if OnlineCode.where(code: online_code_hash['code']).present?
      next if Reward.where(slug: online_code_hash['slug']).blank?

      reward = Reward.where(slug: online_code_hash['slug']).first
      online_code = OnlineCode.new(code: online_code_hash['code'], reward_id: reward.id)
      online_code.save!
    end
  end
end
