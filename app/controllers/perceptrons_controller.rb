class PerceptronsController < ApplicationController
  before_action :set_perceptron, only: [:show, :update, :destroy]

  # GET /perceptrons
  def index
    @perceptrons = Perceptron.all

    render json: @perceptrons
  end

  # GET /perceptrons/1
  def show
    render json: @perceptron
  end

  # POST /perceptrons
  def create
    @perceptron = Perceptron.new(perceptron_params)

    if @perceptron.save
      render json: @perceptron, status: :created, location: @perceptron
    else
      render json: @perceptron.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /perceptrons/1
  def update
    if @perceptron.update(perceptron_params)
      render json: @perceptron
    else
      render json: @perceptron.errors, status: :unprocessable_entity
    end
  end

  # DELETE /perceptrons/1
  def destroy
    @perceptron.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perceptron
      @perceptron = Perceptron.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def perceptron_params
      params.require(:perceptron).permit(:size)
    end
end
