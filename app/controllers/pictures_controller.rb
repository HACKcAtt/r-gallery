class PicturesController < ApplicationController

  def create
   # pic = Picture.new(current_user.id, params[:picture][:description], params[:picture][:link])

    @picture = Picture.new(picture_params)

    if @picture.save
      redirect_to "/users/#{current_user.id}/pictures/#{@picture.id}"
    else
      flash.now[:error] = "Произошла ошибка при загрузек фотографии!"
      render 'new'
    end

    #redirect_to root_url
  end

  def show
    @pic = Picture.find_by(id: params[:id])
    @comments = @pic.comments
    @comment = Comment.new
    #flash[:pic] = @comments.any?
    render 'show'

  end

  def destroy
    session[:return_to] ||= request.referer
    Picture.find_by(id: params[:id]).destroy
    redirect_to current_user
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_picture
    @picture = Picture.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def picture_params
    params.require(:picture).permit(:link, :description).merge(user_id: current_user.id)
  end

end
