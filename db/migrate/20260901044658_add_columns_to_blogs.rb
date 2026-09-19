class AddColumnsToBlogs < ActiveRecord::Migration[7.2]
  def change
    add_column :blogs, :title, :string
    add_column :blogs, :content, :text
    add_column :blogs, :start_time, :datetime
  end
end
