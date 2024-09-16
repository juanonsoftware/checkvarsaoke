class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.integer :row_number
      t.datetime :date_time
      t.integer :amount
      t.string :content
      t.string :status
      t.integer :page_number
      t.timestamps
    end
  end
end
