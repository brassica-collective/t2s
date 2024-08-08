class FboAccountStatement < ApplicationRecord
  belongs_to :fbo_account

  validates :original_filename, presence: true, on: :create
  validates :file_contents, presence: true, on: :create

  def file=(value)
    return if value.nil?

    self.original_filename = value.original_filename
    self.file_contents = value.read
  end

  def import!
    # Import the statement contents here
    update! imported_at: Time.current
  end
end
