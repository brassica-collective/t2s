require "ofx"

class Importers::OfxImporter
  def import(input, fbo_account_statement)
    OFX(input) do |ofx|
      account = ofx.account
      raise "No account found in OFX file" if account.nil?

      validate_account(fbo_account_statement, account.id)

      account.transactions.each do |transaction|
        import_transaction(transaction, fbo_account_statement)
      end
    end
  end

  def import_transaction(transaction, fbo_account_statement)
    existing = find_existing_transaction(transaction, fbo_account_statement)
    if existing
      validate_transaction(existing, transaction)
    else
      create_transaction(transaction, fbo_account_statement)
    end
  end

  private

  def validate_account(fbo_account_statement, account_id)
    fbo_account = fbo_account_statement.fbo_account
    unless fbo_account.bank_account_number == account_id
      raise "Incorrect account, expected account number #{fbo_account.bank_account_number}, got #{account_id}"
    end
  end

  def find_existing_transaction(transaction, fbo_account_statement)
    fbo_account_statement.transactions.find_by(index_in_statement: transaction.fit_id)
  end

  def validate_transaction(existing, transaction)
    if existing.posted_at != transaction.posted_at
      raise "Transaction date mismatch, expected #{existing.posted_at}, got #{transaction.posted_at}"
    end

    if existing.amount_cents != transaction.amount_in_pennies
      raise "Transaction amount mismatch, expected #{existing.amount_cents}, got #{transaction.amount_in_pennies}"
    end

    if existing.memo != transaction.memo
      raise "Transaction memo mismatch, expected #{existing.memo}, got #{transaction.memo}"
    end
  end

  def create_transaction(transaction, fbo_account_statement)
    fbo_account_statement.transactions.create!(
      fbo_account: fbo_account_statement.fbo_account,
      posted_at: transaction.posted_at,
      amount_cents: transaction.amount_in_pennies,
      memo: transaction.memo,
      index_in_statement: transaction.fit_id
    )
  end
end
