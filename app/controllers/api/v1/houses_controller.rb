class Api::V1::HousesController < Api::V1::ApiController
  before_action :load_house, only: %i[show update destroy]
  before_action :build_house, only: %i[create update]

  def index
    @houses = House.all
  end

  def show; end

  def create
    save_house(:created)
  end

  def update
    save_house(:ok)
  end

  def destroy
    @house.destroy
  end

  private

  def load_house
    @house ||= House.find(params[:id])
  end

  def build_house
    @house ||= House.new
    @house.attributes = house_params
  end

  def house_params
    house_params = params
    house_params ? house_params.permit(:name, :address, :user_id) : {}
  end

  def save_house(status)
    if @house.save
      render :show, status: status
    else
      render json: { errors: @house.errors }, status: :unprocessable_entity
    end
  end
end
