class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :show, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @users = User.order(sort_column + ' ' + sort_direction).paginate(per_page: 20, page: params[:page])
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      set_session_and_cookies(@user)
      transfer_urls_from_session(@user)
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def admin_user
      begin
        redirect_to(root_url) unless current_user.admin?
      rescue # when current_user becomes nil after logging out
        redirect_to(root_url)
      end
    end

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : 'email'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
