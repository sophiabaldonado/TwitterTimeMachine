class TimeTweet < ActiveRecord::Base


  def self.find_tweet(timewarp)
    timewarp = timewarp.to_i
    tweets = TimeTweet.where(timezone: timewarp)
    if tweets.empty?
      tweets = TimeTweet.where(timezone: (timewarp - 1)..(timewarp + 1))
    end
    if tweets.empty?
      tweets = TimeTweet.where(timezone: (timewarp - 2)..(timewarp + 2))
    end
    if tweets.empty?
      tweet = ["Sorry No Tweets"]
    end

    tweets.max_by { |tweet| tweet.popularity }
  end
end
