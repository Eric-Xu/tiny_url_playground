class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :converted_url
      t.integer :page_view
      t.integer :user_id

      t.timestamps
    end
  end
end
