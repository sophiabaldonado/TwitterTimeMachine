class TimeTweet < ActiveRecord::Base

  def self.find_tweets(timewarp)
    timewarp = timewarp.to_i

    zoned_tweets = self.zoned_tweets(timewarp)

    minutes_passed = 15
    current_tweets = self.recent_tweets(zoned_tweets, minutes_passed)
    while current_tweets.empty? && minutes_passed <= 720
      current_tweets = self.recent_tweets(zoned_tweets, minutes_passed)
      minutes_passed += 15
    end
    current_tweets
  end

  private

  def self.recent_tweets(zoned_tweets, minutes_passed)
    zoned_tweets.select { |tweet| tweet.tweeted_at.between?((Time.now - 60 * minutes_passed), Time.now) }
  end

  def self.zoned_tweets(timewarp, timezone_offset=0, tweets=[])
    positive_offset = timewarp + timezone_offset
    negative_offset = timewarp - timezone_offset
    return tweets if positive_offset > 12 && negative_offset < -12 #look at min and max
    return tweets if !timewarp.between?(-12, 12)
    return tweets if tweets.any?
    tweets = TimeTweet.where(timezone: negative_offset..positive_offset)
    zoned_tweets(timewarp, (timezone_offset + 1), tweets)
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
