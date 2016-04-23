class Profile < ActiveRecord::Base
  belongs_to :user
  validate :at_least_one_name
  validates_inclusion_of :gender, in: ["male", "female"]

  private

  def  at_least_one_name
    if first_name.blank? && last_name.blank?
      errors.add(:base, "must have either a first or last name")
    end
  end
end
