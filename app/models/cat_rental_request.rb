class CatRentalRequest < ActiveRecord::Base

  before_validation(on: :create) do
    self.status = "PENDING" unless self.status
  end

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(APPROVED PENDING DENIED), message: "asdf"}
  validates_with RentalsValidators

end
