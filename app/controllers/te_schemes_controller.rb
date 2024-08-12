class TeSchemesController < ApplicationController
  before_action :load_scheme, only: [:show, :reaggregate]

  def show
  end

  def reaggregate
    Contributions::MonthlyAggregateService.new.aggregate_all(@scheme)
    redirect_to @scheme
  end

  private

  def load_scheme
    @scheme = TeScheme.find(params[:id])
  end
end