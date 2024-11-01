module HasMonth
  extend ActiveSupport::Concern

  included do
    composed_of :month, class_name: 'Month', mapping: [ %w(year year), %w(month_number number) ]

    scope :date_order, -> { order(year: :asc, month_number: :asc) }
    scope :newest_first, -> { order(year: :desc, month_number: :desc) }
    scope :before_month, ->(month) { where("year < ? OR (year = ? AND month_number < ?)", month.year, month.year, month.number) }
    default_scope { date_order }
    scope :for_month, ->(month) { where(year: month.year, month_number: month.number) }
    scope :current, -> { for_month(Month.now) }
    scope :latest, -> { newest_first.first }
  end

  def self.latest
    newest_first.first
  end
end