# require 'httparty'

class TimeTweeter
  # wrapper for twitter gem
  OFFSET = 3600 # divide the utc offset by this to get it in single hour offsets

  attr_reader :text, :user, :timezone, :created_at, :coordinates, :timezone_map

  def initialize(tweet)
    if tweet != nil
      @text = tweet.text
      @user = tweet.user
      @timezone = get_timezone(tweet)
      @created_at = tweet.created_at
      @coordinates = tweet.geo.coordinates
      # @timezone_map = timezone_map(tweet)
    end

  end

  # def self.find_tweet(timewarp)
  #   auth = {username: ENV["TWITTER_USER"], password: ENV["TWITTER_PASSWORD"]}
  #   tweets = HTTParty.get('https://api.twitter.com/1.1/search/tweets.json?q=%40twitterapi', basic_auth: auth).parsed_response
  #   self.new(tweets)
  # end


  def self.find_tweet(timewarp)
    timewarp = timewarp.to_i
    coords = self.zone_coords(timewarp)
    tweets = TwitterClient.search("quadra", result_type: "recent", count: 10).to_a
    tweets = tweets.select { |t| (t.user.utc_offset / OFFSET).between?((timewarp - 2), timewarp + 2)}
    tweet = tweets.max_by { |t| t.favorite_count + t.retweet_count }
    # tweet = tweets[0]
    tweets.each do |t|
      self.new(t)
    end
  end

  def self.find_place(place="Seattle")
    place = TwitterClient.search(place)
    self.new(place.first)
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


  # def timezone_map(tweet)
  #   c = tweet.geo.coordinates
  #   GmapsClient.timezone(c)
  #
  # end

  def get_timezone(tweet)
    tweet.user.utc_offset / OFFSET
  end
end
