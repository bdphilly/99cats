class RentalsValidators < ActiveModel::Validator
  def validate(cat_rental)
    @candidates = cat_rental.class.where(cat_id: cat_rental.cat_id).where(status: 'APPROVED').pluck(:start_date, :end_date)

    start = cat_rental.start_date
    finish = cat_rental.end_date

    @candidates.each do |range|
      if start.between?(range[0],range[1])
        cat_rental.errors[:start_date] << 'overlapping start dates'
      elsif finish.between?(range[0],range[1])
        cat_rental.errors[:end_date] << 'overlapping end dates'
      elsif start < range[0] && finish > range[1]
        cat_rental.errors[:start_date] << 'overlap'
      end
    end
  end
end