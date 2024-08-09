class TeSchemesController < ApplicationController
  def show
    load_scheme
  end

  private

  def load_scheme
    @scheme = TeScheme.find(params[:id])
  end
end