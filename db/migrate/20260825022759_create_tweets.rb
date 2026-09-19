class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.string :event
      t.date :date
      t.text :about

      t.timestamps
    end
  end
end
