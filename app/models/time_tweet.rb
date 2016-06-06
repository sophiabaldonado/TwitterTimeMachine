require 'timezone'

class TimeTweet < ActiveRecord::Base

  def self.find_tweets(timewarp, starting_timezone)
    offset = timewarp.to_i + starting_timezone.to_i

    zoned_tweets = self.zoned_tweets(offset)

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

  def self.popular_tweet(timewarp, starting_timezone)
    current_tweets = self.find_tweets(timewarp, starting_timezone)

    if current_tweets.empty?
      tweet = ["Sorry No Tweets"]
    else
      tweet = current_tweets.max_by { |t| t.popularity }
    end

    return tweet
  end

  def self.most_recent_tweet(timewarp, starting_timezone)
    current_tweets = self.find_tweets(timewarp, starting_timezone)

    if current_tweets.empty?
      tweet = ["Sorry No Tweets"]
    else
      tweet = current_tweets.max_by { |t| t.tweeted_at }
    end

    return tweet
  end

  def self.random_tweet(timewarp, starting_timezone)
    current_tweets = self.find_tweets(timewarp, starting_timezone)

    if current_tweets.empty?
      tweet = ["Sorry No Tweets"]
    else
      tweet = current_tweets.sample
    end

    return tweet
  end

  def self.time(timewarp, starting_timezone, tweet_time)
    timezone_offset = timewarp.to_i + starting_timezone.to_i

    coords = self.zone_coords(timezone_offset)
    timezone = Timezone.lookup(coords[0], coords[1])
    timezone.utc_to_local(tweet_time)
  end

  def self.zone_coords(offset)
    # prolly find an api that does this -_-;
    zone_coords = {
      "12"  => [-17.734978, 168.322821],
      "11"  => [-33.916990, 151.165184],
      "10"  => [35.835973, 139.148079],
      "9"   => [14.507375, 121.018727],
      "8"   => [13.751229, 100.727425],
      "7"   => [50.999333, 71.787514],
      "6"   => [27.709918, 68.175791],
      "5"   => [19.355895, 56.701688],
      "4"   => [-21.799596, 46.287599],
      "3"   => [39.886387, 33.028011],
      "2"   => [9.056341, 7.412197],
      "1"   => [51.5287352,-0.3817818],
      "0"   => [14.948879, -23.517330],
      "-1"  => [-54.159730, -36.712747],
      "-2"  => [61.157936, -45.427781],
      "-3"  => [-16.494469, -68.033072],
      "-4"  => [40.745270, -73.977763],
      "-5"  => [19.421347, -99.129364],
      "-6"  => [62.447821, -114.379475],
      "-7"  => [47.617755, -122.332083],
      "-8"  => [61.200744, -149.721082],
      "-9"  => [-17.550479, -149.482197],
      "-10" => [-19.131769, -169.884360],
      "-11" => [0.811671, -176.618611],
      "-12" => [-36.865823, 174.789578]
    }
    zone_coords[offset.to_s]
  end

end
