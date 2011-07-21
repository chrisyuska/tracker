class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.integer :created_by
      t.string :category
      t.decimal :amount, :precision => 10, :scale => 2
      t.text :comments
      t.boolean :paid, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
