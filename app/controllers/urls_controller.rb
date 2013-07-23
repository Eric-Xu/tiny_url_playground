class UrlsController < ApplicationController
	def index
		@urls = Url.all
	end

	def new
		@url = Url.new
	end

	def create
		@url = Url.new(params[:url])
		if @url.save
			redirect_to root_url, notice: "Success!"
		else
			render :index
		end
	end
end
