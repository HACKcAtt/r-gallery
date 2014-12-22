module PicturesHelper

  def is_hidden?
    @pic = Picture.find_by(id: params[:id])
    @pic.hidden
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
