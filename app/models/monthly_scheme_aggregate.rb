class MonthlySchemeAggregate < ApplicationRecord
  include HasMonth
  include HasMoney

  STREAM_IDS = [:bm, :te, :cs].freeze

  money :te_issue
  money :te_delta
  money :te_demurrage
  money :te_total
  money :te_total_value
  money :fbo_funds_added
  money :fbo_expenditure
  money :fbo_funds_total
  money :asset_total

  enum status: { open: 'open', closed: 'closed' }

  belongs_to :te_scheme

  validates :year, presence: true
  validates :month_number, presence: true, uniqueness: { scope: [:te_scheme_id, :year] }
  validates :status, presence: true

  scope :current_closed, -> { closed.latest }

  def previous_aggregate
    te_scheme.monthly_aggregates.before_month(month).date_order.last
  end

  def liquidity
    #raise "#{fbo_funds_total.inspect} / #{te_total.inspect}"
    divide_or_default fbo_funds_total, te_total, 1.0
  end

  def stream_dollar_value(stream_id)
    validate_stream_id(stream_id)

    case stream_id
    when :bm
      Money.new(0)
    when :te
      te_total_value
    when :cs
      [asset_total - stream_dollar_value(:te), Money.new(0)].max
    end
  end

  def total_stream_dollar_value
    STREAM_IDS.map {|id| stream_dollar_value(id) }.sum
  end

  def stream_ratio(stream_id)
    validate_stream_id(stream_id)

    divide_or_default(stream_dollar_value(stream_id), total_stream_dollar_value)
  end

  def te_value_ratio
    divide_or_default(te_total_value, te_total)
  end

  private

  def divide_or_default(numerator, denominator, default = 0)
    return default if denominator.zero?
    numerator / denominator
  end

  def validate_stream_id(stream_id)
    raise "Invalid stream_id: #{stream_id}" unless STREAM_IDS.include?(stream_id)
  end

end
