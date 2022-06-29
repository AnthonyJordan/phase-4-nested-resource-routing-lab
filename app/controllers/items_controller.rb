class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def index
    if(params[:user_id])
    items = User.find(params[:user_id]).items
    else
    items = Item.all
    end
    render json: items, include: :user
  end

  def show
  item = Item.find(params[:id])
  render json: item
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create(name: params[:name],price: params[:price], description: params[:description])
    render json: item, status: 201
  end

  private
  def render_not_found_response
    render json: {errors: "Not found"}, status: 404
  end

  
end
