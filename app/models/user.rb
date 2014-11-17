class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :applicants

  USER_ROLES = {
    :admin => 0,
    :standard => 1,
    :sample => 2
  }

  def is_admin?
    return false if role.nil?

    role == User::USER_ROLES[:admin]
  end

  def is_sample?
    return false if role.nil?

    role == User::USER_ROLES[:sample]
  end

  def active_for_authentication?
    # The sample user's applicant's information is used in form-filling
    # examples when no user is logged in.  It's not an actual login user.
    super and not self.is_sample?
  end
end
