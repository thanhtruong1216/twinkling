class BackfillVotesCount < ActiveRecord::Migration[7.0]
  def up
    # Update votes_count cho Option
    Option.find_each do |o|
      Option.where(id: o.id).update_all(votes_count: o.votes.size)
    end

    # Update votes_count cho Poll (tổng số vote của tất cả option trong poll)
    Poll.find_each do |p|
      Poll.where(id: p.id).update_all(votes_count: p.options.sum(:votes_count))
    end
  end

  def down
    # không rollback
  end
end
