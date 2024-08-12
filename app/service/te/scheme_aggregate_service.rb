class Te::SchemeAggregateService
  def initialize
    @contribution_aggregate_service = Te::ContributionAggregateService.new
  end

  def aggregate_all(scheme)
    contribution_aggregate_service.aggregate_all(scheme)
  end

  private

  attr_reader :contribution_aggregate_service
end
