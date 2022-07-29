class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @users = User.find(params[:id])
    if @users == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def update
    @users = User.find(params[:id])

      if @users.update(user_params)
        redirect_to  user_path(@users.id),notice: 'successfully'

      else
        render :edit
      end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
