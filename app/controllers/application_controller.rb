class ApplicationController < ActionController::Base
  protect_from_forgery
  $UPDATE_FEED=true
  Feedentry.update_feeds
end
