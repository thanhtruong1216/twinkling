# frozen_string_literal: true

class EventTracksController < ApplicationController
  def index
    @event_tracks = EventTrack.all.order(user_id: :asc)
  end
end
