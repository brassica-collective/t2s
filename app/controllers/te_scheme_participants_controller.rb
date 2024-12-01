class TeSchemeParticipantsController < ApplicationController
  before_action :load_scheme
  before_action :load_participant, only: [:show]

  def index
    @participants = @scheme.participants
  end

  def new
    @participant = @scheme.participants.new
  end

  def create
    @participant = @scheme.participants.new create_params

    if @participant.save
      redirect_to te_scheme_participants_path(@scheme), notice: "Participant created"
    else
      render :new
    end
  end

  def show
    @monthly_aggregates = @participant.monthly_aggregates.closed
    @current_aggregate = @participant.monthly_aggregates.current_closed
    @monthly_aggregate = @scheme.monthly_aggregates.current_closed
  end

  private

  def create_params
    params.require(:te_scheme_participant).permit(:name)
  end

  def load_scheme
    @scheme = TeScheme.find params[:te_scheme_id]
  end

  def load_participant
    @participant = @scheme.participants.find params[:id]
  end
end