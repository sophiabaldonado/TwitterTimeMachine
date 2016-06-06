class TimeTweetsController < ApplicationController


  def index
    @time_tweet = TimeTweet.new(nil)
    # @place_tweet = TimeTweet.find_place
    @src = "https://www.google.com/maps/embed/v1/search?key=#{ENV["GOOGLE_SERVER_KEY"]}&q=record+stores+in+Seattle"
  end

  def create
    @popular_tweet = TimeTweet.popular_tweet(params["timewarp"])
    @embeded_tweet = TwitterClient.oembed(@popular_tweet.twitter_id)
    @most_recent_tweet = TimeTweet.most_recent_tweet(params["timewarp"])
    @random_tweet = TimeTweet.random_tweet(params["timewarp"])
    render :show
  end

  def show

  end

end
