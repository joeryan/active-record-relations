class Profile < ActiveRecord::Base
  belongs_to :user
  validate :at_least_one_name
  validate :no_boys_named_sue
  validates_inclusion_of :gender, in: ["male", "female"]

  def self.get_all_profiles(startYear, endYear)
    Profile.where("birth_year BETWEEN :min_year AND :max_year",
                    min_year: startYear, max_year: endYear).order(:birth_year)
  end

  private

  def no_boys_named_sue
    if first_name == "Sue" && gender == "male"
      errors.add(:base, "You can't name a boy Sue!")
    end
  end

  def  at_least_one_name
    if first_name.blank? && last_name.blank?
      errors.add(:base, "must have either a first or last name")
    end
  end
end
