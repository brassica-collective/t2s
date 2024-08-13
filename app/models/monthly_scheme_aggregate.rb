class MonthlySchemeAggregate < ApplicationRecord
  include HasMonth
  include HasMoney

  STREAM_IDS = [:bm, :te, :cs].freeze

  money :te_issue
  money :te_delta
  money :te_demurrage
  money :te_total
  money :fbo_funds_added
  money :fbo_expenditure
  money :fbo_funds_total

  belongs_to :te_scheme

  validates :year, presence: true
  validates :month_number, presence: true, uniqueness: { scope: [:te_scheme_id, :year] }

  def previous_aggregate
    te_scheme.monthly_aggregates.before_month(month).date_order.last
  end

  def liquidity
    #raise "#{fbo_funds_total.inspect} / #{te_total.inspect}"
    fbo_funds_total / te_total
  end

  def stream_dollar_value(stream_id)
    validate_stream_id(stream_id)

    case stream_id
    when :bm
      Money.new(0)
    when :te
      te_total
    when :cs
      fbo_funds_total - te_total
    end
  end

  def total_stream_dollar_value
    STREAM_IDS.map {|id| stream_dollar_value(id) }.sum
  end

  def stream_ratio(stream_id)
    validate_stream_id(stream_id)

    stream_dollar_value(stream_id) / total_stream_dollar_value
  end

  private

  def validate_stream_id(stream_id)
    raise "Invalid stream_id: #{stream_id}" unless STREAM_IDS.include?(stream_id)
  end

end
