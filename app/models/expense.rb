class Expense < ActiveRecord::Base
  belongs_to :user, :foreign_key => "created_by"

  validates_presence_of :category, :amount, :created_by
  validates :amount, :numericality => true
end
