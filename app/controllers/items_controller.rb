class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end
  
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @comments = @item.comments
    @comment = current_user.comments.new
  end

  def edit
    @item = Item.find(params[:id])
    if @item.user != current_user
      flash[:notice] = "不正なアクセスです。"
      redirect_to items_path
    end
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end
  
  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to user_path(item.user), notice: 'アイテムを削除しました。'
  end
  
  
  
  private
  def item_params
    params.require(:item).permit(:title, :body, :image)
  end
end
