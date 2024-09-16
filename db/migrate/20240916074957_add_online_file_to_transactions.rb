class AddOnlineFileToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_reference :transactions, :online_file, null: false, foreign_key: true
  end
end
