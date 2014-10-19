class RequestsController < ApplicationController
  def index
    render json: Request.all, root: false, status: :ok
  end

  def create
    request = Request.create_with_entities! permitted_params
    render json: request, status: :created
  end

  def show
    render json: Request.find(params[:id]), root: false, status: :ok
  end

  private

  def permitted_params
    params.permit(:request_string)
  end
end
