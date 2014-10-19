class RequestsController < ApplicationController
  def index
    render json: Request.limit(15).order('created_at desc').all, root: false, status: :ok
  end

  def create
    request = Request.create_with_entities! permitted_params
    render json: request, scope: 'entities', status: :created
  end

  def show
    render json: Request.find(params[:id]), scope: 'entities', root: false, status: :ok
  end

  private

  def permitted_params
    params.permit(:request_string)
  end
end
