class FboAccountStatementsController < ApplicationController
  before_action :load_account

  def index
  end

  private

  def load_account
    @account = FboAccount.find params[:fbo_account_id]
  end
end