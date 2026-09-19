class AddDatetimeToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :datetime, :datetime
  end
end
