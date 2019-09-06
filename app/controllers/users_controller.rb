class UsersController< ApplicationController
  before_action :require_user, except: [:new, :create]

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.name}! You are now registered and logged in."
      redirect_to "/profile"
    else
      flash[:error] = user.errors.full_messages.uniq.to_sentence
      redirect_to "/register"
    end
  end

  def show
    @user = current_user
    render :profile
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)

    if @user.save
      flash[:success] = "Your profile has been updated"
      redirect_to "/profile"
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_to "/profile/edit"
    end
  end

  private
  def user_params
    params.permit(:name, :address, :city, :state, :zipcode, :email, :password, :password_confirmation)
  end

  def require_user
    render file: "/public/404" if current_user.nil?
  end
end
