require "ofx"

class Importers::OfxImporter
  def import(input, fbo_account_statement)
    OFX(input) do |ofx|
      validate_account(fbo_account_statement, ofx.account.id)

      raise "bank_id:#{ofx.account.bank_id} currency:#{ofx.account.currency} id:#{ofx.account.id} type:#{ofx.account.type}"

    end
  end

  private

  def validate_account(fbo_account_statement, account_id)
    fbo_account = fbo_account_statement.fbo_account
    unless fbo_account.bank_account_number == account_id
      raise "Incorrect account, expected account number #{fbo_account.bank_account_number}, got #{account_id}"
    end
  end
end
