class RequestsController < ApplicationController
  def index
    render json: Request.all, root: false, status: :ok
  end

  def create
    Request.find_entities person_params
    render nothing: true, status: :created
  end

  def show
    render json: Request.find(params[:id]), root: false, status: :ok
  end

  private

  def person_params
    params.require(:entities)
  end
end
