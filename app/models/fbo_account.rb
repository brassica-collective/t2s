class FboAccount < ApplicationRecord
  has_many :statements, class_name: FboAccountStatement.name

  validates :name, presence: true
  validates :bank_account_number, presence: true
end
