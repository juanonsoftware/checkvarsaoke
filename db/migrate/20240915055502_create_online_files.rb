class CreateOnlineFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :online_files do |t|
      t.string :name
      t.string :path
      t.integer :pages
      t.integer :processed_pages
      t.string :status

      t.timestamps
    end
  end
end
