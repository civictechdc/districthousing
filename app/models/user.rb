class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :applicants

  ROLES = {
    :admin => 0,
    :standard => 1
  }

  def is_admin?
    role == 0
  end
end
