class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user

      flash[:success] = "Добро пожаловать!"
      redirect_to @user
    else
      render "new"

    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])

    #@picture = Picture.where("user_id = #{@user.id}").to_a
    @picture = Picture.where("user_id = ?", @user.id)
    if !current_user?(@user)
      @picture = @picture.where(hidden: false)
    end
    @picture = @picture.paginate(page: params[:page], per_page: 8)
    #flash[:qwe] = @picture.first.link.thumb

  end

  private
  def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def signed_in_user
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
