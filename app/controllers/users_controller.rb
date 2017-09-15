class UsersController < Clearance::UsersController

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  def show
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    # something

    if @user.save
      # do something
    else
      # do something else
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
