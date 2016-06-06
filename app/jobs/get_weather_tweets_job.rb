class GetWeatherTweetsJob < ActiveJob::Base
  queue_as :default

  OFFSET = 3600

  def perform
    tweets = TwitterClient.search("weather", result_type: "recent", count: 5).to_a
    tweets.each do |tweet|
      timetweet = TimeTweet.find_or_create_by(twitter_id: tweet.id)
      timetweet.text = tweet.text
      timetweet.user = tweet.user
      timetweet.popularity = tweet.retweet_count + tweet.favorite_count
      timetweet.tweeted_at = tweet.created_at
      timetweet.timezone = tweet.user.utc_offset / OFFSET
      timetweet.coordinates = tweet.geo.coordinates
      timetweet.twitter_id = tweet.id

      timetweet.save
    end
  end
end
