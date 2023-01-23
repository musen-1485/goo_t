class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_back(fallback_location: root_path)  #コメント送信後は、一つ前のページへリダイレクトさせる。
    else
      redirect_back(fallback_location: root_path)  #同上
    end
  end
  
  def destroy
   @item = Item.find(params[:item_id])
      comment = @item.comments.find(params[:id])
      if current_user.id == comment.user.id
        comment.destroy
      redirect_back(fallback_location: root_path)
      
      end
  end
  

  private
  def comment_params
    params.require(:comment).permit(:comment_content, :item_id)  #formにてpost_idパラメータを送信して、コメントへitem_idを格納するようにする必要がある。
  end
end
