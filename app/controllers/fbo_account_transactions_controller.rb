class FboAccountTransactionsController < ApplicationController
  before_action :load_fbo_account
  before_action :load_transaction, only: [:assign, :expend]

  def assign
    Te::IndividualContributionService.new.assign_fbo_transaction(@transaction, load_participant)
    reload_index
  end

  def expend
    Te::ExpenditureService.new.expend_fbo_transaction(@transaction)
    reload_index
  end

  def withdraw
    Te::IndividualContributionService.new.withdraw_fbo_transaction(@transaction, load)
  end

  def index
    @scheme = @account.te_scheme
  end

  private

  def reload_index
    load_fbo_account
    index
    render action: :index
  end

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
