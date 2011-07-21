class Category < ActiveRecord::Base
  has_many :expenses

  validates_presence_of :name
end
