class RssreaderController < ApplicationController
  def index
    @feedentry = Feedentry.order('publish_at DESC').paginate(page: params[:page],  :per_page => 15)
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
