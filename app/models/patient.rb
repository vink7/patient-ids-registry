class Patient < ActiveRecord::Base

  has_one :identification, dependent: :destroy
  has_one :rec, dependent: :destroy

  validates_presence_of :first_name, :last_name, :email, :dob
  validates_uniqueness_of :email

  validates_associated :identification
  validates_associated :rec

  accepts_nested_attributes_for :identification, allow_destroy: true
  accepts_nested_attributes_for :rec, allow_destroy: true

  include PgSearch::Model

  pg_search_scope(
    :search,
    against: %i(
      first_name
      last_name
      email
      dob
    ),
    using: {
      tsearch: {
        dictionary: "english",
      }
    }
  )

  def id_expired?
    self.identification.exp_date.to_date.past?
  end

  def rec_expired?
    self.rec.exp_date.to_date.past?
  end

end
