class FboAccountsController < ApplicationController
  def index
    @accounts = FboAccount.all
  end

  def show
    redirect_to fbo_account_transactions_path(@account)
  end
end
