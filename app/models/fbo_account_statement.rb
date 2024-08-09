class FboAccountStatement < ApplicationRecord
  belongs_to :fbo_account

  VALID_FORMATS = ['ofx'].freeze

  validates :original_filename, presence: true, on: :create
  validates :file_contents, presence: true, on: :create
  validates :format, inclusion: { in: VALID_FORMATS }, allow_nil: true

  def file=(value)
    return if value.nil?

    self.original_filename = value.original_filename
    self.file_contents = value.read
  end

  def import!
    Importers.for(format).new.import(file_contents, self)
    update! imported_at: Time.current
  end

  private

  before_validation on: :create do
    self.format = File.extname(original_filename).delete('.')
  end
end
