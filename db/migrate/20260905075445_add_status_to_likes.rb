class AddStatusToLikes < ActiveRecord::Migration[7.2]
  def change
    add_column :likes, :status, :string
  end
end
