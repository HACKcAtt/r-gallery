class PicturesController < ApplicationController
  before_action :signed_in_user, only: [:show, :index, :edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]


  def create
   # pic = Picture.new(current_user.id, params[:picture][:description], params[:picture][:link])

    @picture = Picture.new(picture_params)

    if @picture.description.blank?
      @picture.description = "none"
    end

    if @picture.save
      redirect_to "/users/#{current_user.id}/pictures/#{@picture.id}"
    else
      flash.now[:error] = "Произошла ошибка при загрузкe фотографии!"
      flash.now[:message] = @picture.errors.full_messages
      render 'new'
    end

    #redirect_to root_url
  end

  def show

    @pic = Picture.find_by(id: params[:id], user_id: params[:user_id])
    if @pic.hidden
      session[:return_to] ||= request.referer
      @user_master = User.find(@pic.user_id)
      if !current_user?(@user_master)
        flash[:message] = "Доступ запрещен!"
        redirect_to session.delete(:return_to) and return
      end

    end
    @comments = @pic.comments
    @comment = Comment.new
    #flash[:pic] = @comments.any?
    render 'show'

  end

  def destroy
       logger.debug "~~~~~~~~~~~DEBUG INFO: somethin #{params} "
       Picture.find_by(id: params[:id], user_id: params[:user_id]).destroy
    session[:return_to] ||= request.referer

    redirect_to current_user
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_picture
    @picture = Picture.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def picture_params
    params.require(:picture).permit(:link, :description, :hidden).merge(user_id: current_user.id)
  end

  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def signed_in_user
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end
end
