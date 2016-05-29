require_relative '../../config/initializers/twitter'
class TimeTweetsController < ApplicationController


  def index
    @t = TwitterClient.search("#ruby -rt", :lang => "ja").first.text
  end

  def show

  end

end
