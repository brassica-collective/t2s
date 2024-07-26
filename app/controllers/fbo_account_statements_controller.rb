class FboAccountStatementsController < ApplicationController
  before_action :load_account

  def index
  end

  def new
    @statement = FboAccountStatement.new
  end

  def create
    @statement = FboAccountStatement.new(create_params)
    if @statement.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  private

  def load_account
    @account = FboAccount.find params[:fbo_account_id]
  end

  def create_params
    params.require(:fbo_account_statement).permit(:file)
  end
end