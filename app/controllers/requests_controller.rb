class RequestsController < ApplicationController
  def index
    render json: Request.all, root: false, status: :ok
  end

  def create
    request = Request.create person_params
    render json: request, status: :created
  end

  def show
    render json: Request.find(params[:id]), root: false, status: :ok
  end

  private

  def person_params
    params.require(:entities)
  end
end
