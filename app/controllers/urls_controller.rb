class UrlsController < ApplicationController

	def index

	end

	 # find the real link for the shortened link key and redirect
  def show
  	params.permit!
    # only use the leading valid characters
    token = /^([#{Shortener.key_chars.join}]*).*/.match(params[:id])[1]

    # pull the link out of the db
    sl = ::Shortener::ShortenedUrl.unexpired.where(unique_key: token).first

    if sl
      # don't want to wait for the increment to happen, make it snappy!
      # this is the place to enhance the metrics captured
      # for the system. You could log the request origin
      # browser type, ip address etc.
      Thread.new do
        sl.increment!(:use_count)
        ActiveRecord::Base.connection.close
      end

      params.except *[:id,:action, :controller]
      
      if params.present?
        uri = URI.parse(sl.url)
        existing_params = Rack::Utils.parse_nested_query(uri.query)
        merged_params   = existing_params#.merge(params)
        uri.query       = merged_params.to_query
        url             = uri.to_s
      end
      # do a 301 redirect to the destination url
      redirect_to url, status: :moved_permanently
    else
      # if we don't find the shortened link, redirect to the root
      # make this configurable in future versions
      redirect_to Shortener.default_redirect
    end
  end

  def create_short_url
    unless url_params[:long_url].blank?
      short_url = Shortener::ShortenedUrl.generate(url_params[:long_url], owner: current_user,expires_at: 10.days.since)
    end
    redirect_to home_path
  end

  def update
    url = current_user.shortened_urls.where(id: params[:id]).first

    respond_to do |format|
      if url.update(url_update_params)
        format.json { render json: url, status: :ok }
      else
        format.json { render json: url.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    url = current_user.shortened_urls.where(id: params[:id]).first
    Shortener::ShortenedUrl.destroy(url.id)
    redirect_to home_path
  end

  private

    def url_params
      params.permit(:long_url)
    end

    def url_update_params
      params.require(:shortener_shortened_url).permit(:url)
    end
	
end
