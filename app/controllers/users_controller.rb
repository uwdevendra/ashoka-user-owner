class UsersController < ApplicationController
  load_and_authorize_resource

  before_filter :admin_belongs_to_current_org?

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.organization_id = params[:organization_id]
    @user.role = 'user'
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def admin_belongs_to_current_org?
    redirect_to(root_path) unless current_user.organization_id.to_s == params[:organization_id]
  end
end
