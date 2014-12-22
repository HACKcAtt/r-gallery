class CommentsController < ApplicationController
  def create
    #current_user заменить на текущую пикчу
    @pic = Picture.find_by(id: comment_params[:pic_id])
    @comment = @pic.comments.build({content: comment_params[:content], user_id: comment_params[:user_id]})
    #flash[:qwe] = @pic.id

    if @comment.save
      flash[:success] = "Comment Added"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy

  end

  private

    def comment_params
      params.require(:comment).permit(:content, :pic_id).merge(user_id: current_user.id)
    end
end
