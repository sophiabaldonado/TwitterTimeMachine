# require 'google_maps_service'
#
# # Setup global parameters
# GoogleMapsService.configure do |config|
#   config.key = ENV["GOOGLE_SERVER_KEY"]
#   config.retry_timeout = 20
#   config.queries_per_second = 10
# end
#
# # Initialize client using global parameters
# ::GmapsClient = GoogleMapsService::Client.new

Timezone::Lookup.config(:google) do |c|
  c.api_key = ENV["GOOGLE_SERVER_KEY"]
end
