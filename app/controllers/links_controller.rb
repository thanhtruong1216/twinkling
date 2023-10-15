# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :set_link, only: %i[update destroy]

  def index
    @links = current_user.links.order(created_at: :asc)
  end

  def show
    @link = current_user.links.find_by(slug: params[:id])
    @link.clicks.create

    redirect_to @link.url
  end

  def new
    @link = current_user.links.build
  end

  def create
    @link = current_user.links.build(link_params)

    if @link.save
      redirect_to links_path
    else 
      render 'new'
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    if @link.update(link_params)
      redirect_to links_path
    end
  end

  def destroy
    @link.destroy
    redirect_to links_path
  end

  private

  def link_params
    params.require(:link).permit(:url, :slug, :title)
  end
  
  def set_link
    @link = current_user.links.find_by(id: params[:id])
  end
end
