class Public::UsersController < ApplicationController
   before_action :authenticate_user!
   before_action :ensure_correct_user, only: [:edit, :update]

   def show
    @user = User.find(params[:id])
    @item_comments = @user.item_comments
   end

   def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
   end

   def update
     @user = User.find(params[:id])
     if@user.update(user_params)
     redirect_to user_path(@user.id),notice:"更新しました"
     else
     render :edit
     end
   end

   def destroy
    @user = User.find(params[:id])
    @user.destroy  # データ（レコード）を削除
    redirect_to users_path(@user.id),notice:"削除しました"
   end

   private
!
   def user_params
     params.require(:user).permit(:name, :introduction, :profile_image,:item_comments)
   end

   def ensure_correct_user
      @user = User.find(params[:id])
     unless @user == current_user
      redirect_to user_path(current_user)
     end
   end
end
