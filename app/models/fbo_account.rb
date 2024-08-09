class FboAccount < ApplicationRecord
  has_many :statements, class_name: FboAccountStatement.name
  has_many :transactions, class_name: FboAccountTransaction.name
  has_one :te_scheme

  validates :name, presence: true
  validates :bank_account_number, presence: true
end
