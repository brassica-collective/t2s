class TeSchemeParticipantsController < ApplicationController
  before_action :load_scheme

  def index
    @participants = @scheme.participants
  end

  private

  def load_scheme
    @scheme = TeScheme.find params[:te_scheme_id]
  end
end