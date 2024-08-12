class MonthlySchemeAggregatesController < ApplicationController
  before_action :load_scheme, only: [:index]

  def index
    @monthly_aggregates = @scheme.monthly_aggregates
  end

  private

  def load_scheme
    @scheme = TeScheme.find(params[:te_scheme_id])
  end
end