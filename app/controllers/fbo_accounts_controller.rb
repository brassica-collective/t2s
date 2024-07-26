class FboAccountsController < ApplicationController
  def index
    @accounts = FboAccount.all
  end
end
