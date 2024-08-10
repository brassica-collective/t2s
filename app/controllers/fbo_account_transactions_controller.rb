class FboAccountTransactionsController < ApplicationController
  before_action :load_fbo_account

  def assign
    load_transaction
    Contributions::IndividualContributionService.new.assign_fbo_transaction(@transaction, load_participant)
  end

  private

  def load_fbo_account
    @account = FboAccount.find(params[:fbo_account_id])
  end

  def load_transaction
    @transaction = @account.transactions.find(params[:id])
  end

  def load_participant
    @participant = @account.te_scheme.participants.find(params[:participant_id])
  end
end
