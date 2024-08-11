class TeSchemeContributionsController < ApplicationController
  before_action :load_scheme
  before_action :load_contribution, only: [:reaggregate]

  def index
    @contributions = @scheme.contributions
  end

  def reaggregate
    service = Contributions::MonthlyAggregateService.new
    service.aggregate(@contribution.participant, Month(@contribution.received_at))
  end

  private

  def load_contribution
    @contribution = @scheme.contributions.find(params[:id])
  end

  def load_scheme
    @scheme = TeScheme.find params[:te_scheme_id]
  end
end