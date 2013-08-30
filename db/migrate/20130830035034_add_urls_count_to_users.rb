class AddUrlsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :urls_count, :integer, default: 0

    User.reset_column_information
    User.all.each do |u|
    	User.update_counters u.id, urls_count: u.urls.length
    end
  end
end
