class TimeTweet < ActiveRecord::Base

  FIFTEEN_MIN = 15*60
  THIRTY_MIN = 30*60
  ONE_HOUR = 60*60

  def self.find_tweet(timewarp)
    timewarp = timewarp.to_i

    zoned_tweets = TimeTweet.where(timezone: timewarp)
    if zoned_tweets.empty?
      zoned_tweets = TimeTweet.where(timezone: (timewarp - 1)..(timewarp + 1))
    end
    if zoned_tweets.empty?
      zoned_tweets = TimeTweet.where(timezone: (timewarp - 2)..(timewarp + 2))
    end

    current_tweets = zoned_tweets.select { |tweet| tweet.tweeted_at.between?((Time.now - FIFTEEN_MIN), Time.now) }
    if current_tweets.empty?
      current_tweets = zoned_tweets.select { |tweet| tweet.tweeted_at.between?((Time.now - THIRTY_MIN), Time.now) }
    end
    if current_tweets.empty?
      current_tweets = zoned_tweets.select { |tweet| tweet.tweeted_at.between?((Time.now - ONE_HOUR), Time.now) }
    end

    if current_tweets.empty?
      tweet = ["Sorry No Tweets"]
    else
      tweet = current_tweets.max_by { |t| t.popularity }
    end

    tweet
  end
end
