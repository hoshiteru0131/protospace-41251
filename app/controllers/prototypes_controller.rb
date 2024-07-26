class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :redirect_unless_logged_in, except: [:index, :show]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  

  def index
    @prototypes = Prototype.all

  end

  def new
    @prototype = Prototype.new
  end


  def create
    @prototype = Prototype.new(prototypes_params)
    if @prototype.save
      redirect_to root_path, notice: 'Prototype was successfully created.'
    else
      render :new 
    end
    
  end
  
  def edit
    @prototype = Prototype.find(params[:id])
  end


  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)

  end


  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototypes_params)
      redirect_to prototype_path(@prototype), notice: 'Prototype was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path, notice: 'Prototype was successfully deleted.'
  end


  private

  def prototypes_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
  def redirect_unless_logged_in
    redirect_to new_user_session_path unless user_signed_in?
  end

  
  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def authorize_user!
    @prototype = Prototype.find(params[:id])
    unless @prototype.user == current_user
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end


end
