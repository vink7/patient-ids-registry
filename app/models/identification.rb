class Identification < ActiveRecord::Base

  belongs_to :patient

  validates_presence_of :id_number, :state_issuer, :exp_date, :url
  validates_uniqueness_of :id_number

  validate :exp_date_cannot_be_in_the_past

  def exp_date_cannot_be_in_the_past
    if exp_date.present? && exp_date.to_date.past?
      errors.add(:exp_date, "can't be in the past")
    end
  end

  include PgSearch::Model

  pg_search_scope(
    :search,
    against: %i(
      id_number
      state_issuer
      exp_date
      url
    ),
    using: {
      tsearch: {
        dictionary: "english",
      }
    }
  )

end
