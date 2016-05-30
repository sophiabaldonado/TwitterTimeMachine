class TimeTweetsController < ApplicationController


  def index
    @tweet = TimeTweet.find_tweet
    @place_tweet = TimeTweet.find_place
    @src = "https://www.google.com/maps/embed/v1/search?key=#{ENV["GOOGLE_SERVER_KEY"]}&q=record+stores+in+Seattle"
  end

  def show

  end

end
