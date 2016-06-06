class TimeTweet < ActiveRecord::Base

  FIFTEEN_MIN = 15*60
  THIRTY_MIN = 30*60
  ONE_HOUR = 60*60

  def self.find_tweets(timewarp)
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
    return current_tweets
  end

  def self.popular_tweet(timewarp)
    current_tweets = self.find_tweets(timewarp)

    if current_tweets.empty?
      tweet = ["Sorry No Tweets"]
    else
      tweet = current_tweets.max_by { |t| t.popularity }
    end

    return tweet
  end

  def self.most_recent_tweet(timewarp)
    current_tweets = self.find_tweets(timewarp)

    if current_tweets.empty?
      tweet = ["Sorry No Tweets"]
    else
      tweet = current_tweets.max_by { |t| t.tweeted_at }
    end

    return tweet
  end

  def self.random_tweet(timewarp)
    current_tweets = self.find_tweets(timewarp)

    if current_tweets.empty?
      tweet = ["Sorry No Tweets"]
    else
      tweet = current_tweets.sample
    end

    return tweet
  end
end
