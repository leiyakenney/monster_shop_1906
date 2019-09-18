class AddressesController< ApplicationController
  before_action :require_user, except: [:new, :create]

  def new
    @user = current_user
    @address = Address.new
  end

  def create
    @user = current_user
    @address = @user.addresses.new(address_params)
    if @address.save
      flash[:success] = "Thank you for adding your #{@address.nickname} address!"
      redirect_to profile_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @address = Address.find(params[:id])
    @user = @address.user
  end

  def update
    @address = Address.find(params[:id])
    @user = @address.user
    if @address.shipped_orders.empty? && @address.update(address_params)
      flash[:success] = "Your address has been updated!"
      redirect_to profile_path
    else
      flash[:error] = "Your address has not been updated."
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @user = @address.user
    if @address.shipped_orders.empty?
      @address.destroy
      flash[:success] = "Your address has been deleted!"
    else
      flash[:error] = 'Address cannot be deleted at this time.'
    end
    redirect_to profile_path
  end

  def index
    @user = current_user
  end

  private
  def address_params
    params.permit(:name, :address, :city, :state, :zip, :nickname)
  end

end
