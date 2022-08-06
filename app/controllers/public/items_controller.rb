class Public::ItemsController < ApplicationController
   before_action :authenticate_user!, only: [:show, :create]

   def index
    @genres = Genre.where(is_enabled: true)
    if params[:genre_id].nil?
      @items_all = Item.joins(:genre).where(genres: { is_enabled: true }).where(is_enabled: true)
      # ジャンルが有効かつ商品も販売中の商品のみ表示させる
      @items = @items_all.reverse_order
      @index = "商品"
    else
      @items_all = Item.joins(:genre).where(genres: { is_enabled: true, id: params[:genre_id] }).where(is_enabled: true)
      @items = @items_all.reverse_order
      @index = Genre.find( params[:genre_id]).name
    end
   end

   def show
     @item = Item.find(params[:id])
     @comments = @item.comments
     @item_comment = ItemComment.new
     @genres = Genre.where(is_enabled: true)
   end

   private

   def item_params
     params.require(:item).permit(:name, :explanation, :image, :genre_id, :price, :is_enabled)
   end
end
