class HousesController < ApplicationController
  before_action :set_house, only: %i[show edit update destroy]

  def index
    @houses = policy_scope(House)
  end

  def search
    authorize :house, :search?
    index

    if params[:query].present?
      @houses = @houses.search_by_name_and_address(params[:query]).uniq
    end

    render :index
  end

  def show; end

  def new
    @house = authorize House.new
    @title = "Nouvelle maison"

    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def create
    @house = authorize House.new(house_params)
    @house.user = current_user

    respond_to do |format|
      if @house.save
        @notice = "La maison a bien été créée."
        format.html { redirect_to houses_path, notice: @notice }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
      format.js {}
    end
  end

  def edit
    @title = "Modifier la maison"

    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def update
    respond_to do |format|
      if @house.update(house_params)
        @notice = "La maison a bien été modifiée."
        format.html { redirect_to house_path(@house), notice: @notice }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
      format.js {}
    end
  end

  def destroy
    @house.destroy
    @notice = "La maison a bien été supprimée."

    respond_to do |format|
      format.html { redirect_to houses_path, notice: @notice }
      format.js {}
    end
  end

  def export_data
    authorize :house, :export_data?
  end

  private

  def set_house
    @house = authorize policy_scope(House).find(params[:id])
  end

  def house_params
    params.require(:house).permit(:name, :address, photos: [])
  end
end
