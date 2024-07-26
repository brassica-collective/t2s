class FboAccountsController < ApplicationController
  def index
    @accounts = FboAccount.all
  end

  def show
    @account = FboAccount.find(params[:id])
  end
end
