class GetTweetsJob < ActiveJob::Base
  queue_as :default

  def get_tweets
    # Do something later
  end
end
