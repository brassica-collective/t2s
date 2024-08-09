class FboAccountsController < ApplicationController
  def index
    @accounts = FboAccount.all
  end

  def show
    @account = FboAccount.find(params[:id])
    @scheme = @account.te_scheme
  end
end
