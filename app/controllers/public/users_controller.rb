class Public::UsersController < ApplicationController
   before_action :authenticate_user!
   before_action :ensure_correct_user, only: [:edit, :update]

   def show
    @user =current_user
    @user = User.find(params[:id])
   end

   def edit
    @user = current_user
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

   def user_params
     params.require(:user).permit(:last_name,:first_name, :introduction, :profile_image)
   end
end
