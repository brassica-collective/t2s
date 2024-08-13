class FboAccountsController < ApplicationController
  def index
    @accounts = FboAccount.all
  end

  def show
    @account = FboAccount.find(params[:id])
    redirect_to fbo_account_transactions_path(@account)
  end
end
