class Direction < ActiveRecord::Base
  has_many :entries, dependent: :destroy
  belongs_to :scenario

  def completed(current_user)
    @entry = Entry.where(direction_id: self.id, user_id: current_user.id)
    @entry.any?
  end

  def user_entry(current_user)
    Entry.where(direction_id: self.id, user_id: current_user.id).first
  end
end
