class Building < ActiveRecord::Base
  attr_accessible :address, :email, :fax, :name, :phone
end
