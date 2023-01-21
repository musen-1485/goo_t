class FavoritesController < ApplicationController
  before_action :authenticate_user!
 
  def create
    item = Item.find(params[:item_id])
    current_user.favorite(item)
    redirect_back fallback_location: root_path, success: t('defaults.message.favorite')
  end

  def destroy
    item = current_user.favorites.find(params[:id]).item
    current_user.unfavorite(item)
    redirect_back fallback_location: root_path, success: t('defaults.message.unfavorite')
  end
  
 
end
