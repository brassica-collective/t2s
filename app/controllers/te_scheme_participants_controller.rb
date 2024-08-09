class TeSchemeParticipantsController < ApplicationController
  before_action :load_scheme

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

  private

  def create_params
    params.require(:te_scheme_participant).permit(:name)
  end

  def load_scheme
    @scheme = TeScheme.find params[:te_scheme_id]
  end
end