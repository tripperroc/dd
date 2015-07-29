class Student < ActiveRecord::Base
  attr_accessible :student_type
  @@response_size = 10
  validate :eligible, :too_many
  def eligible
    if !((student_type == "RIT" || student_type == "NTID") && (gender == "Male" || gender == "Female"))
	errors.add(:student_type, "Not an RIT or NTID student")
    end
  end
  def too_many
#    if Student.where(student_type: student_type, gender: gender).where.not(facebook_user_id: 0).count >= @@response_size
    if Student.where("student_type = ? and gender = ? and not gender = 0", student_type, gender).count >= @@response_size
        errors.add(:student_type, "Too many responses")
    end
  end
end
