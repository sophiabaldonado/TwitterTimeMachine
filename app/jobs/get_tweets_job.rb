class GetTweetsJob < ActiveJob::Base
  queue_as :default

  OFFSET = 3600

  def self.get_tweets
    tweets = TwitterClient.search("a", result_type: "recent", count: 5).to_a
    tweets.each do |tweet|
      t = TimeTweet.new
      t.text = tweet.text
      t.user = tweet.user
      t.popularity = tweet.retweet_count + tweet.favorite_count
      t.tweeted_at = tweet.created_at
      t.timezone = tweet.user.utc_offset / OFFSET
      t.coordinates = tweet.geo.coordinates

      t.save
    end
  end
end
