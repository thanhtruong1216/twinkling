# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :set_link, only: %i[update destroy]

  def index
    EventTrack.create(name: 'View shorten links', user_id: current_user.id)
    @links = current_user.links.order(created_at: :desc)
  end

  def show
    # EventTrack.create(name: 'View shorten link detail', user_id: current_user.id)
    # @link = current_user.links.find_by(slug: params[:id])
    # @link.clicks.create

    # redirect_to @link.url
  end

  def new
    EventTrack.create(name: 'Prepare shortern link', user_id: current_user.id)
    @link = current_user.links.build
  end

  def create
    @link = current_user.links.build(link_params)

    if @link.save
      EventTrack.create(name: 'Create shortern link', user_id: current_user.id)
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
      EventTrack.create(name: 'Update shorten link', user_id: current_user.id)
      redirect_to links_path
    end
  end

  def destroy
    EventTrack.create(name: 'Destroy shorten link', user_id: current_user.id)
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
