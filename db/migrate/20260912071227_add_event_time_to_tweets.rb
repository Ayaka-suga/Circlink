class AddEventTimeToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :start_time, :datetime
    add_column :tweets, :end_time, :datetime
  end
end
