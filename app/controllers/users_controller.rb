class UsersController < Clearance::UsersController
  before_action :admin_only, only: [:index, :destroy]

  def index
    @users = User.all.order(:id)
  end

  def show
    # allowed?(action: "show_user", user: current_user)

    if params[:id].nil?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render "users/new"
    end
  end

  def edit
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        flash[:notice] = "Sorry. Access denied."
        return redirect_back(fallback_location: root_path)
      end
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :avatar, :remote_avatar_url)
  end

end
