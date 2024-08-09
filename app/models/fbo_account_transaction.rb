class FboAccountTransaction < ApplicationRecord
  belongs_to :fbo_account_statement
  belongs_to :fbo_account
end
