class Api::V1::HousesController < Api::V1::ApiController
  def index
    @houses = House.all
  end

  def show
    load_house
  end

  def create
    build_house
    if @house.save
      render :show, status: :created
    else
      render json: { errors: @house.errors }, status: :unprocessable_entity
    end
  end

  def update
    load_house
    build_house
    if @house.save
      render :show, status: :ok
    else
      render json: { errors: @house.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    load_house
    @house.destroy
  end

  private

  def load_house
    @house ||= House.find(params[:id])
  end

  def build_house
    @house ||= House.build
    @house.attributes = house_params
  end

  def house_params
    house_params = params
    house_params ? house_params.permit(:name, :address, :user_id) : {}
  end
end
