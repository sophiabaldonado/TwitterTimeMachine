class TimeTweetsController < ApplicationController
  def index
    @time_tweet = TimeTweet.new(nil)
    # @place_tweet = TimeTweet.find_place
    # @src = "https://www.google.com/maps/embed/v1/search?key=#{ENV["GOOGLE_SERVER_KEY"]}&q=record+stores+in+Seattle"
  end

  def create
    timewarp = params["timewarp"]
    zone = params["timezone"]

    popular_tweet = TimeTweet.popular_tweet(timewarp, zone)
    most_recent_tweet = TimeTweet.most_recent_tweet(timewarp, zone)
    random_tweet = TimeTweet.random_tweet(timewarp, zone)

    @display_time = TimeTweet.time(timewarp, zone, popular_tweet.tweeted_at)
    @sunrise_time = TimeTweet.time(timewarp, zone, popular_tweet.tweeted_at)
    @sunset_time = TimeTweet.time(timewarp, zone, popular_tweet.tweeted_at)
    @adjusted_timezone = timewarp.to_i + zone.to_i

    @embeded_popular_tweet = TwitterClient.oembed(popular_tweet.twitter_id)
    @embeded_most_recent_tweet = TwitterClient.oembed(most_recent_tweet.twitter_id)
    @embeded_random_tweet = TwitterClient.oembed(random_tweet.twitter_id)

    params["timewarp"].to_i < 0 ? @selected_time = "Past" : @selected_time = "Future"
    render :show
  end

  def show
  end

end
