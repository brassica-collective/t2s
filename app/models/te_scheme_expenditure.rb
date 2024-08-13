class TeSchemeExpenditure < ApplicationRecord
  include HasMoney

  belongs_to :te_scheme
  belongs_to :fbo_account_transaction

  money :amount


end
