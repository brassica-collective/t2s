class FboAccountStatementsController < ApplicationController
  before_action :load_account

  def index
  end

  def new
    @statement = FboAccountStatement.new
  end

  def create
    @statement = FboAccountStatement.new
  end

  private

  def load_account
    @account = FboAccount.find params[:fbo_account_id]
  end
end