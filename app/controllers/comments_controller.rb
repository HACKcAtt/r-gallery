class CommentsController < ApplicationController
  def create
    #current_user заменить на текущую пикчу
    @pic = Picture.find_by(id: comment_params[:pic_id])
    @comment = @pic.comments.build({content: comment_params[:content], user_id: comment_params[:user_id]})
    #flash[:qwe] = @pic.id

    # Это было до добавления ajax запроса.
    # if @comment.save
    #   session[:return_to] ||= request.referer
    #   flash[:success] = "Комментарий добавлен"
    #
    #   redirect_to :back
    # else
    #   render 'static_pages/home'
    # end



    respond_to do |format|  # позволяет контролеру откликаться на запрос Ajax
      if @comment.save
        format.html { redirect_to @pic }
        format.js {}
        format.json { render json: @pic }
      else

        format.html { render action: "new" }
        format.json { render json }
      end
    end

  end

  def destroy
    # До ajax:
    # # Запоминаем откуда пришли
    # session[:return_to] ||= request.referer
    # # Выполняем действие - уничтожаем комментарий
    # Comment.find_by(id: params[:id]).destroy
    # # После выполнения действия возвращаемся назад
    # redirect_to :back

    # Для поиска картинки (теперь передается как параметр)
    # @pic = Picture.find_by(id: Comment.find_by(id: params[:id]).picture_id)

    @pic = Picture.find_by(id:params[:pic_id])
    respond_to do |format|  # позволяет контролеру откликаться на запрос Ajax
      if Comment.find_by(id: params[:id]).destroy

     #   logger.debug "~~~~~~~~~~~DEBUG INFO: somethin #{params} "
        format.html { redirect_to @pic }
        format.js {}
        format.json { render json: @pic }
      else
        format.html { render action: "new" }
        format.json { render json }
      end
    end

  end

  private

    def comment_params
      params.require(:comment).permit(:content, :pic_id).merge(user_id: current_user.id)
    end
end
