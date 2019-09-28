class UsersController< ApplicationController
  before_action :require_user, except: [:new, :create]
  before_action :set_user, except: [:new, :create]

  def set_user
    @user = current_user
  end

  def new

  end

  def create
    @user = User.create!(user_params)
    @user.save
    @address = @user.addresses.create(address_params)
    if @address.nickname == nil
      @address.update(nickname: "home")
    end
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.name}! You are now registered and logged in."
      redirect_to "/profile"
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    render :profile
  end

  def edit
  end

  def update
    @user.update(user_params)
    if @user.save
      flash[:success] = "Your profile has been updated"
      redirect_to "/profile"
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_to "/profile/edit"
    end
  end

  def edit_password
  end

  def update_password
    @user.update(user_params)
    if @user.save
      flash[:success] = "Your password has been updated"
      redirect_to "/profile"
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_to "/profile/edit_password"
    end
  end

  def show_orders
    @item_orders = @user.item_orders
  end

  def show_order
    @order = Order.find(params[:id])
    @item_orders = @user.item_orders
    @indiv_order = @item_orders.display_info(@order)
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def address_params
    params.permit(:name, :address, :city, :state, :zip, :nickname)
  end
end
