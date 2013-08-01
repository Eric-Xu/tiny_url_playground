class UrlsController < ApplicationController
  before_action :set_url, only: [:destroy]

	def index
    @url = Url.new
		@urls = []
    if current_user
      @urls = current_user.urls
    elsif session[:url_ids] && session[:url_ids].any?
      @urls = Url.find(session[:url_ids])
    end
	end

	def new
		@url = Url.new
	end

  def create
    @url = Url.new(url_params)
    @url.user = current_user

    if @url.save
      if session[:url_ids]
        session[:url_ids] << @url.id
      else
        session[:url_ids] = [@url.id]
      end
      redirect_to root_url, notice: 'Url was successfully created.'
    else
      flash[:error] = "#{@url.errors.full_messages.to_sentence}."
      redirect_to root_url
      # cannot use render because need to hold onto instance variables
    end
  end

  def show
    @url = Url.find_by_converted_url(params[:converted_url])
    @url.update_column(:page_view, @url.page_view += 1)
    redirect_to check_url_protocol(@url.original_url)
  end

  def destroy
    session[:url_ids].delete(@url.id)
    @url.destroy
    redirect_to root_url, notice: "Url successfully deleted."
  end

  private
    def set_url
      @url = Url.find(params[:id])
    end

    def url_params
      params.require(:url).permit(:original_url)
    end

    def check_url_protocol(url)
      if /\Ahttp/.match(url)
        unless /\A(http|https):\/\/www/.match(url)
          "http://www.#{url}"
        end
        url
      else
        "http://#{url}"
      end
    end
end
