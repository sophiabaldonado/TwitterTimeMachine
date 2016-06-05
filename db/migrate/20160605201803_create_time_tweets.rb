class CreateTimeTweets < ActiveRecord::Migration
  def change
    create_table :time_tweets do |t|

      t.string :text
      t.integer :popularity
      t.datetime :tweeted_at
      t.integer :timezone
      t.string :user
      t.string :coordinates

      t.timestamps null: false
    end
  end
end
