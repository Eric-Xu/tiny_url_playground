class UrlsController < ApplicationController
  before_action :set_url, only: [:destroy, :delete]
  skip_before_filter :verify_authenticity_token # for testing js only; opens CSRF attacks

	def index
    @url = Url.new
		@urls = []
    if current_user
      @urls = current_user.urls
      # @urls = current_user.urls.order('created_at DESC')
    elsif session[:url_ids] && session[:url_ids].any?
      @urls = Url.find(session[:url_ids])
      # @urls = Url.find(session[:url_ids]).reverse
    end
	end

	def new
		@url = Url.new
	end

  def create
    @url = Url.new(url_params)
    @url.user = current_user

    respond_to do |format|
      if @url.save
        if session[:url_ids]
          session[:url_ids] << @url.id
          # session[:url_ids].unshift(@url.id)
        else
          session[:url_ids] = [@url.id]
        end
        format.html { redirect_to root_url, notice: 'Url was successfully created.' }
        format.js { render action: 'create_success.js.erb' }
      else
        format.html do
          flash[:error] = "#{@url.errors.full_messages.to_sentence}."
          redirect_to root_url
          # cannot use render because need to hold onto instance variables
        end
        format.js { render action: 'create_fail.js.erb' }
      end
    end
  end

  def show
    @url = Url.find_by_converted_url(params[:converted_url])
    if @url
      @url.update_column(:page_view, @url.page_view += 1)
      respond_to do |format|
        format.html { redirect_to @url.original_url }
        format.js
      end
    else
      redirect_to root_url
    end
  end

  def destroy
    session[:url_ids].delete(@url.id) unless session[:url_ids].nil?
    @url.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: "Url successfully deleted." }
      format.js
    end
  end

  def delete # delete urls when js is disabled
  end

  private
    def set_url
      @url = Url.find(params[:id])
    end

    def url_params
      params.require(:url).permit(:original_url)
    end
end
