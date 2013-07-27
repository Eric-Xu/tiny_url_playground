class AddDefaultValueToPageView < ActiveRecord::Migration
	def up
	  change_column :urls, :page_view, :integer, :default => 0
	end

	def down
	  change_column :urls, :page_view, :integer, :default => nil
	end
end
