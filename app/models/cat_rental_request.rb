class CatRentalRequest < ActiveRecord::Base

  before_validation(on: :create) do
    self.status ||= "PENDING"
  end

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(APPROVED PENDING DENIED), message: "asdf"}
  validates_with RentalsValidators

  belongs_to(
    :cat,
    :class_name => "Cat",
    :foreign_key => :cat_id,
    :primary_key => :id,
    :dependent => :destroy
  )

end
