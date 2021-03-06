class UsersController < ApplicationController

 def new
  @user = User.new
 end

 def create
  @user = User.new(user_params)
  if @user.save
    session[:id] = @user.id
    redirect_to '/'
  else
    @errors = @user.errors.full_messages
    render 'new'
  end
 end

def show
  @user = User.find(params[:id])
end

def edit
  @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])

  if @user.update(user_params)
    redirect_to @user
  else
    render 'edit'
  end
end

private
def user_params
  params.require(:user).permit(:name, :username, :password)
end

end
