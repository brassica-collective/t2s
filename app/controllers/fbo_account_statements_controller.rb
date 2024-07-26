class FboAccountStatementsController < ApplicationController
  before_action :load_account

  def index
    @statements = @account.statements
  end

  def new
    @statement = FboAccountStatement.new
  end

  def create
    @statement = @account.statements.build(create_params)
    if @statement.save
      redirect_to action: :index
    else
      raise @statement.errors.inspect
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