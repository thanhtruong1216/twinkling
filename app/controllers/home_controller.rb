class HomeController < ApplicationController
  def index
    @polls = Poll.active_polls.includes(options: :votes).order(created_at: :desc)
    @hot_polls = @polls.sort_by { |p| -p.options.sum { |opt| opt.votes.size } }.first(6)
  end
end
