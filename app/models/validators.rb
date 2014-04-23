class Validators < ActiveModel::Validator
  def validate(cat)
    unless ['black', 'brown', 'white', 'red', 'blue', 'grey'].include?(cat.color.downcase)
      cat.errors[:color] << 'not a cat color'
    end
  end

  def validate(cat)
    unless ['M', 'F'].include?(cat.sex.upcase)
      cat.errors[:sex] << 'not a cat sex'
    end
  end
end

# class SexValidator < ActiveModel::Validator
#
#   end
# end