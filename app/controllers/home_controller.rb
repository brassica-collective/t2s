class HomeController < ApplicationController
  def index
    @accounts = FboAccount.all
    @schemes = TeScheme.all
  end
end