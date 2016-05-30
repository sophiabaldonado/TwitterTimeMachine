class TimeTweet
  # wrapper for twitter gem
  OFFSET = 3600 # divide the utc offset by this to get it in single hour offsets

  attr_reader :text, :user, :timezone, :created_at, :coordinates, :timezone_map

  def initialize(tweet)
    @text = tweet.text
    @user = tweet.user
    @timezone = get_timezone(tweet)
    @created_at = tweet.created_at
    @coordinates = tweet.geo.coordinates
    # @timezone_map = timezone_map(tweet)
  end

  def self.find_tweet(query="weather")
    tweet = TwitterClient.search("weather -rt").first
    self.new(tweet)
  end

  def self.find_place(place="Seattle")
    place = TwitterClient.search(place)
    self.new(place.first)
  end

  def timezone_map(tweet)
    zones = {
      "-1" => []


    }
    c = tweet.geo.coordinates
    GmapsClient.timezone(c)

  end

  def get_timezone(tweet)
    tweet.user.utc_offset / OFFSET
  end
end
