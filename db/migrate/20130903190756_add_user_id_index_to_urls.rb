class AddUserIdIndexToUrls < ActiveRecord::Migration
  def change
  	add_index :urls, :user_id
  end
end
