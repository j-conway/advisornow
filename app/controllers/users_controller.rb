class UsersController < ApplicationController
  before_action :authenticate
  #before_action :correct_user, only: [:edit, :update]
  #before_action :admin_user, only: [:edit, :update, :destroy]
  before_action :same_company, :unless => :alpine_session?, only: [:show]
  before_action :correct_company, :unless => :alpine_session?, only: [:index]
  before_action :user_or_admin_check, :colleague, :unless => :alpine_session?,  only: [:edit, :update]
  before_action :company_admin_check, :unless => :alpine_session?, only: [:new, :create]
  before_action :admin_user, only: :destroy

  def index
    if params[:company_id]
      company = Company.find(params[:company_id])
      @users = company.users.paginate(page:params[:page])
    else
      user_filter
      unpaginated_users = User.user_filter_is(@user_filter)
      @users = unpaginated_users.paginate(page:params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
    consults_filter
    @company = @user.company
    unpaginated_consults = @user.consults.status_is(@consult_filter)
    ordered_consults = unpaginated_consults.select("consults.*").joins(:meetings).where("meetings.status = 'Open'").group("consults.id").order("min(meeting_datetime)")
    @consults = unpaginated_consults.paginate(page:params[:page])
  end

  def new
    @user = User.new
  end


  def create
    if user_params[:alpine_user] == "1" && alpine_session?
      @company = Company.find(1)
      @user = @company.users.build(user_params)
    else
      @company = Company.find(params[:company_id])
      @user = @company.users.build(user_params)
      @user.admin = false
    end
    if @user.save
      #sign_in @user
      flash[:success] = "User " + @user.name + " added."
      redirect_to company_path(@company)
    else
      render 'new'
    end
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :phone_number, :alpine_user, :company_admin, :entitled, :company_id)
    end



    # Before filters

    def alpine_user?
      current_user.alpine_user?
    end
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def same_company
      user = User.find(params[:id]) 
      redirect_to(root_url) unless current_company?(user.company)
    end

    def colleague
      @user = User.find(params[:id])
      company_id = @user.company_id 
      redirect_to(root_url) unless current_user.company_id = company_id
    end

    def correct_company
      if params[:company_id]
        company = Company.find(params[:company_id]) 
        redirect_to(root_url) unless current_company?(company)
      else
        redirect_to(root_url)
      end
    end
end