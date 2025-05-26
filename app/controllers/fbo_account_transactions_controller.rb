class FboAccountTransactionsController < ApplicationController
  before_action :load_fbo_account
  before_action :load_transaction, only: [:assign, :expend, :new_withdrawal, :withdraw]

  def assign
    Te::IndividualContributionService.new.assign_fbo_transaction(@transaction, load_participant)
    reload_index
  end

  def expend
    Te::ExpenditureService.new.expend_fbo_transaction(@transaction)
    reload_index
  end

  def new_withdrawal
    @scheme = @account.te_scheme
  end

  def withdraw
    reason = params[:reason]
    raise "Reason for withdrawal is required" if reason.blank?

    Te::IndividualContributionService.new.withdraw_fbo_transaction(@transaction, load_participant, reason)
    redirect_to fbo_account_transactions_path(@account), notice: "Withdrawal successfully created."
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
