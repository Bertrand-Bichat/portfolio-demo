class HousesController < ApplicationController
  before_action :set_house, only: %i[show edit update destroy]

  def show; end

  def new
    @house = House.new
  end

  def create
    @house = House.new(house_params)

    respond_to do |format|
      if @house.save
        format.html { redirect_to house_path(@house), notice: "La maison a bien été créée." }
        format.json { render :show, status: :created, location: @house }
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
        format.json { render :show, status: :ok, location: @house }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @house.destroy

    respond_to do |format|
      format.html { redirect_to profil_path(current_user.slug), notice: "La maison a bien été supprimée." }
      format.json { head :no_content }
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
