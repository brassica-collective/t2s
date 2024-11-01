class TeSchemesController < ApplicationController
  before_action :load_scheme, only: [:show, :reaggregate]

  def show
    @monthly_aggregate = @scheme.monthly_aggregates.current_closed
  end

  def reaggregate
    Te::SchemeAggregateService.new.aggregate_participants_and_scheme(@scheme)
    redirect_to @scheme
  end

  private

  def load_scheme
    @scheme = TeScheme.find(params[:id])
  end
end