class Expense < ActiveRecord::Base
  belongs_to :user, :foreign_key => "created_by"

  attr_accessible :cost, :comments, :category, :amount, :paid

  validates_presence_of :category, :amount, :created_by, :comments
  validates :amount, :numericality => true
end
