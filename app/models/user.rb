class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 validate :email_constraint
 validate :name_constraint
 validate :password_constraint

  def email_constraint
    domain = email.split("@").last
    if !email.blank?
      errors.add(:email, "Invalid Domain") unless /\.co$/  === domain
    end
  end
    
  def name_constraint
    if !name.blank?
      errors.add(:name, "Name not allowed") unless /^flexiple_[a-z_]*$/  === name
    end  	
  end

  def password_constraint
    if !password.blank?
      errors.add(:password, "Password not allowed") unless (/[A-Z]{2}+/ === password  && /[*@!#%&()^~{}]{2}+/ === password)
    end  	
  end

end
