class Feedentry < ActiveRecord::Base
  attr_accessible :description, :guid, :link, :publish_at, :title
  belongs_to :Feedurl
  
  
  
  def self.update_feeds()
     logger.info "UPDATE-FEED-1"
    return if(!$UPDATE_FEED)

    $UPDATE_FEED=false

    #############################################
    thread = Thread.new do
      loop do
        logger.info "UPDATE-FEED-2"
        sleep 2.minutes
        #sleep 10
        feedurls = Feedurl.all
        feedurls.each do |feedurl|

          rss = SimpleRSS.parse open(feedurl.feed_url)

          if(rss!=nil && rss.channel.title!=nil)

            rss.entries.each do |entry|
              title = entry.title.gsub(/[^a-z A-Z 0-9 \- ]/,"")
              feedentry = Feedentry.where(title: title, publish_at: entry.pubDate, guid: entry.guid).order('publish_at DESC')

              if(feedentry.empty?)

                feedentry = Feedentry.new
                feedentry.title = title
                feedentry.link = entry.link
                feedentry.publish_at = entry.pubDate
                feedentry.guid = entry.guid
                feedentry.feedurl_id = feedurl.id

                if(feedentry.save)
                  logger.info "NEW FEEDENTRY SAVED!"
                end
              else
                logger.info "FEED ALREADY AVAILABLE: #{title}"

              end

            end

          end
        end
      end
    end

  #############################################

  end
end
