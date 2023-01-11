class HousesController < ApplicationController
  before_action :set_house, only: %i[show edit update destroy]

  def index
    @houses = policy_scope(House)
  end

  def show; end

  def new
    @house = authorize House.new
  end

  def create
    @house = authorize House.new(house_params)
    @house.user = current_user

    respond_to do |format|
      if @house.save
        format.html { redirect_to houses_path, notice: "La maison a bien été créée." }
        format.js {}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @house.update(house_params)
        format.html { redirect_to house_path(@house), notice: "La maison a bien été modifiée." }
        format.js {}
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @house.destroy

    respond_to do |format|
      format.html { redirect_to houses_path, notice: "La maison a bien été supprimée." }
      format.js {}
    end
  end

  private

  def set_house
    @house = authorize policy_scope(House).find(params[:id])
  end

  def house_params
    params.require(:house).permit(:name, :address)
  end
end
