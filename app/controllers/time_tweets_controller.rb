class TimeTweetsController < ApplicationController


  def index
    @tweet = TimeTweet.find_tweet
    @place_tweet = TimeTweet.find_place
  end

  def show

  end

end
