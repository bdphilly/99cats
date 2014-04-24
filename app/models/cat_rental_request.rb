class CatRentalRequest < ActiveRecord::Base

  before_validation(on: :create) do
    self.status ||= "PENDING"
  end

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(APPROVED PENDING DENIED), message: "asdf"}
  validate :does_not_overlap_approved_requests

  belongs_to(
    :cat,
    :class_name => "Cat",
    :foreign_key => :cat_id,
    :primary_key => :id,
    :dependent => :destroy
  )

  def approve!
    raise "not a pending status!" unless self.status == "PENDING"
    transaction do
      self.status = "APPROVED"
      self.save!
      overlapping_pending_requests.update_all(status: 'DENIED')
    end
  end


  def overlapping_requests
    # candidates = CatRentalRequest.where(cat_id: self.cat_id)
    #              .pluck(:start_date, :end_date)
    #
    # start = self.start_date
    # finish = self.end_date
    #
    # [].tap do |overlapping|
    #   candidates.each do |range|
    #     if range[0] == start && range[1] == finish
    #       # do nothing, it is itself
    #     elsif start.between?(range[0],range[1])
    #       overlapping << range
    #     elsif finish.between?(range[0],range[1])
    #       overlapping << range
    #     elsif start < range[0] && finish > range[1]
    #       overlapping << range
    #     end
    #   end
    # end
    #


    conditions = <<-SQL
      (
        (cat_id = :cat_id)
        AND (
          (
            (start_date BETWEEN :start_date AND :end_date)
            OR (end_date BETWEEN :start_date AND :end_date)
          ) OR (
            (:start_date BETWEEN start_date AND end_date)
            OR (:end_date BETWEEN start_date AND end_date)
          )
        )
      )
    SQL

    overlapping_requests = CatRentalRequest.where(conditions, {
      :cat_id => self.cat_id,
      :start_date => self.start_date,
      :end_date => self.end_date
    })

    if self.id.nil?
      overlapping_requests
    else
      overlapping_requests.where("id != ?", self.id)
    end

  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  def approved?
    self.status == "APPROVED"
  end

  def denied?
    self.status == "DENIED"
  end

  def pending?
    self.status == "PENDING"
  end

  def does_not_overlap_approved_requests

    return if self.denied?

    unless overlapping_approved_requests.empty?
      errors[:base] << "Request conflicts with existing approved request"
    end
  end

end
