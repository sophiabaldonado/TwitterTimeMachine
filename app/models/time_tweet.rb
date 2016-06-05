class TimeTweet < ActiveRecord::Base

  FIFTEEN_MIN = 15*60
  THIRTY_MIN = 30*60
  ONE_HOUR = 60*60

  def self.find_tweet(timewarp)
    timewarp = timewarp.to_i

    tweets = TimeTweet.where(timezone: timewarp)
    if tweets.empty?
      tweets = TimeTweet.where(timezone: (timewarp - 1)..(timewarp + 1))
    end
    if tweets.empty?
      tweets = TimeTweet.where(timezone: (timewarp - 2)..(timewarp + 2))
    end

    tweets = tweets.map { |tweet| tweet.tweeted_at.between?((Time.now - FIFTEEN_MIN), Time.now) }
    if tweets.empty?
      tweets = tweets.map { |tweet| tweet.tweeted_at.between?((Time.now - THIRTY_MIN), Time.now) }
    end
    if tweets.empty?
      tweets = tweets.map { |tweet| tweet.tweeted_at.between?((Time.now - ONE_HOUR), Time.now) }
    end

    if tweets.empty?
      tweet = ["Sorry No Tweets"]
    end

  end
end
