class UsersController < ApplicationController

  def index
    @users = User.alphabetical.paginate(:page => params[:page]).per_page(7)
  end

  def show
    @user = User.find(params[:id])
    @user_assignments = @user.assignments.active.by_project
    @created_tasks = Task.for_creator(@user.id).by_name
    @completed_tasks = Task.for_completer(@user.id).by_name
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    authorize! :edit, @user
  end

  def create
    @user = User.new(params[:user])
    unless current_user && current_user.role?(:admin)
      @user.role = "member"
    end
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      flash[:error] = "This user could not be created."
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])
    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    @user.email = params[:user][:email]
    @user.role = params[:user][:role]
    @user.active = params[:user][:active]
    @user.password = params[:user][:password]
    if @user.update_user_attributes
      flash[:notice] = "#{@user.proper_name} is updated."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end
  
  def reset_password
    @user = User.find(params[:id])
  end
  
  def password_reset
    @user = User.find(params[:user_id])
    if params[:password] != params[:password_confirmation]
      flash[:error] = "Passwords do not match."
      redirect_to reset_password(@user)
    else
      User.reset_password(params[:password],params[:user_id])
      flash[:notice] = "Password has been changed."
      redirect_to @user
    end
    
    
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully removed #{@user.proper_name} from Arbeit."
    redirect_to users_url
  end
end
