class AddTwitterIdToTimeTweets < ActiveRecord::Migration
  def change
    add_column :time_tweets, :twitter_id, :string
  end
end
