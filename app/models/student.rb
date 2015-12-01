class Student < ActiveRecord::Base
  attr_accessible :student_type
  @@response_size = 10
  validate :eligible, :too_many
  def eligible
    if (student_type == "OTHER")
	errors.add(:student_type, "Not an RIT or NTID student")
    end
  end
  def too_many
#    if Student.where(student_type: student_type, gender: gender).where.not(facebook_user_id: 0).count >= @@response_size
    if (student_type == "NTID" && Student.where("student_type = ? and substr(gender,1+length(gender)-length(?), length(gender)) = ? and not gender = 0", student_type, gender, gender).count >= @@response_size) || (student_type != "NTID" && Student.where("student_type != 'NTID' and substr(gender,1+length(gender)-length(?), length(gender)) = ? and not gender = 0", gender, gender).count >= @@response_size)
        errors.add(:student_type, "Too many responses")
    end
  end
end
