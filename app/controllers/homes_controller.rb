class HomesController < ApplicationController
  respond_to :html, :json

  before_filter :list_homes, only: [:index]
  before_filter :find_home, only: [:show, :update, :edit, :destroy]

  def index
    if params[:nearby]
      render :nearby, layout: false
    else
      respond_with @homes
    end
  end

  def new
    if params[:guess]
      @home = Home.new(permitted_params)
      @home.reverse_geocode
      render 'new', layout: false
    else
      @home = Home.new
    end
  end

  def create
    @home = Home.new(permitted_params)

    if @home.save
      flash[:notice] = I18n.t('home.flash.new', name: @home.name)
      redirect_to @home
    else
      display_errors
      render 'new'
    end
  end

  def update
    if @home.update(permitted_params)
      flash[:notice] = I18n.t('home.flash.updated')
    else
      display_errors
      render 'edit'
    end

    redirect_to @home
  end

  def destroy
    if @home.destroy
      flash[:notice] = I18n.t('home.flash.deleted')
      redirect_to homes_path
    else
      display_errors
      redirect_to @home
    end
  end

private
  def list_homes
    @homes = Home.all.page(params[:page])
    @homes = if params[:search].present? || params[:map] == "1"
      @homes.near([params[:lat], params[:long]], 20, :order => 'distance')
    else
      @homes.reverse_order
    end
  end

  def display_errors
    if @home.errors.any?
      errors = @home.errors.each do |attribute, message|
        flash[:alert] = I18n.t('home.flash.field')
      end
    else
      flash[:alert] = I18n.t('home.flash.unexpected')
    end
  end

  def find_home
    @home = Home.find(params[:id])
  end

  def permitted_params
    params.require(:home).permit!
  end
end
