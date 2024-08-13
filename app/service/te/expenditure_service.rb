class Te::ExpenditureService
  def expend_fbo_transaction(fbo_transaction)
    existing = find_existing_expenditure(fbo_transaction)
    if existing
      raise "Transaction already assigned to expenditure: #{existing.inspect}"
    else
      expenditure = create_expenditure(fbo_transaction)
    end
  end

  private

  def find_existing_expenditure(fbo_transaction)
    fbo_transaction.te_scheme_expenditure
  end

  def create_expenditure(fbo_transaction)
    TeSchemeExpenditure.create!(
      fbo_account_transaction: fbo_transaction,
      te_scheme: fbo_transaction.fbo_account.te_scheme,
      amount_cents: fbo_transaction.amount_cents,
      occured_at: fbo_transaction.posted_at
    )
  end
end
