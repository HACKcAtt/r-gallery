class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user

      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render "new"

    end
  end

  def show
    @user = User.find(params[:id])

    #@picture = Picture.where("user_id = #{@user.id}").to_a
    @picture = []
     Picture.where("user_id = ?", @user.id).take(5).each do |l|
       @picture.push(l.link.url)
     end
     # @picture.push(l)





    flash[:err] = @picture


  end

  private
  def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end