class TeSchemeContributionsController < ApplicationController
  before_action :load_scheme

  def index
    @contributions = @scheme.contributions
  end

  private

  def load_scheme
    @scheme = TeScheme.find params[:te_scheme_id]
  end
end