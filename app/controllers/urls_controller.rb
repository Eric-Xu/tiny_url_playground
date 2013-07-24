class UrlsController < ApplicationController
  before_action :set_url, only: [:destroy]

	def index
		@urls = Url.all
	end

	def new
		@url = Url.new
	end

  def create
    @url = Url.new(url_params)

    if @url.save
      redirect_to root_url, notice: 'Url was successfully created.'
    else
      render action: 'new'
    end
  end

  def destroy
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
end
