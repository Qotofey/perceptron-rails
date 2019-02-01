class LayersController < ApplicationController
  before_action :set_layer, only: [:show, :update, :destroy]

  # GET /layers
  def index
    @layers = Layer.all

    render json: @layers
  end

  # GET /layers/1
  def show
    render json: @layer
  end

  # POST /layers
  def create
    @layer = Layer.new(layer_params)

    if @layer.save
      render json: @layer, status: :created, location: @layer
    else
      render json: @layer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /layers/1
  def update
    if @layer.update(layer_params)
      render json: @layer
    else
      render json: @layer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /layers/1
  def destroy
    @layer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_layer
      @layer = Layer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def layer_params
      params.require(:layer).permit(:weights)
    end
end
