class TimeTweetsController < ApplicationController


  def index
    @time_tweet = TimeTweet.new(nil)
    @place_tweet = TimeTweet.find_place
    @src = "https://www.google.com/maps/embed/v1/search?key=#{ENV["GOOGLE_SERVER_KEY"]}&q=record+stores+in+Seattle"
  end

  def create
    @time_tweet = TimeTweet.find_tweet(params["timewarp"])
    render :show
  end

  def show

  end

end
