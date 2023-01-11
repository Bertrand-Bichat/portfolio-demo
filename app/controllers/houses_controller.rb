class HousesController < ApplicationController
  before_action :find_house, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_house
    @house = authorize policy_scope(House).find(params[:id])
  end
end
