require 'simple-rss'
require 'open-uri'

class FeedurlsController < ApplicationController
  # GET /feedurls
  # GET /feedurls.json
  def index

    logger.debug ".....INDEX...."
    @feedurls = Feedurl.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feedurls }
    end
  end

  # GET /feedurls/1
  # GET /feedurls/1.json
  def show
    @feedurl = Feedurl.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feedurl }
    end
  end

  # GET /feedurls/new
  # GET /feedurls/new.json
  def new
    @feedurl = Feedurl.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feedurl }
    end
  end

  # GET /feedurls/1/edit
  def edit
    @feedurl = Feedurl.find(params[:id])
  end

  # POST /feedurls
  # POST /feedurls.json
  def create
    rss=nil
    
    # if(params[:feedurl][:feed_url].nil? || params[:feedurl][:feed_url].eql?(""))
      # respond_to do |format|
        # @feedurl = Feedurl.new
        # format.html { render action: "new" }
      # end
      # return
    # end
    
    rss = SimpleRSS.parse open(params[:feedurl][:feed_url]) if(!params[:feedurl][:feed_url].nil? && !params[:feedurl][:feed_url].eql?(""))

    
    if(rss!=nil && rss.channel.title!=nil)
      rss_title = rss.channel.title
      params[:feedurl][:feed_title] = rss_title.gsub(/[^a-z A-Z 0-9 \- ]/,"")
    end

    @feedurl = Feedurl.new(params[:feedurl])

    respond_to do |format|
      if @feedurl.save
        feed_entery(rss, @feedurl)
        format.html { redirect_to @feedurl, notice: 'Feedurl was successfully created.' }
        format.json { render json: @feedurl, status: :created, location: @feedurl }
      else
        format.html { render action: "new" }
        format.json { render json: @feedurl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /feedurls/1
  # PUT /feedurls/1.json
  def update
    @feedurl = Feedurl.find(params[:id])

    respond_to do |format|
      if @feedurl.update_attributes(params[:feedurl])
        format.html { redirect_to @feedurl, notice: 'Feedurl was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feedurl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedurls/1
  # DELETE /feedurls/1.json
  def destroy
    @feedurl = Feedurl.find(params[:id])
    @feedurl.destroy

    respond_to do |format|
      format.html { redirect_to feedurls_url }
      format.json { head :no_content }
    end
  end

  private

  def feed_entery(rss, feedurl)
    rss.entries.each do |entry|
    #puts entry
      feedentry = Feedentry.new
      feedentry.title = entry.title.gsub(/[^a-z A-Z 0-9 \- ]/,"")
      feedentry.link = entry.link
      feedentry.publish_at = entry.pubDate
      feedentry.guid = entry.guid
      feedentry.feedurl_id = feedurl.id

      if(feedentry.save)
        logger.debug "FEEDENTRY SAVED!"
      end
    end
  end

  

end
