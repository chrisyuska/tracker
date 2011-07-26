class AddTypeToExpense < ActiveRecord::Migration
  def self.up
    add_column :expenses, :cost, :string
  end

  def self.down
    remove_column :expenses, :cost
  end
end
