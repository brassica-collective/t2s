module HasMonth
  extend ActiveSupport::Concern

  included do
    composed_of :month, class_name: 'Month', mapping: [ %w(year year), %w(month_number number) ]

    validates :year, presence: true
    validates :month_number, presence: true, uniqueness: { scope: [:te_scheme_participant_id, :year] }

    scope :date_order, -> { order(year: :asc, month_number: :asc) }
    scope :before_month, ->(month) { where("year < ? OR (year = ? AND month_number < ?)", month.year, month.year, month.number) }
    default_scope { date_order }
    scope :for_month, ->(month) { where(year: month.year, month_number: month.number) }
    scope :current, -> { for_month(Month.now).first }
  end
end