# == Schema Information
#
# Table name: goals
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  title           :string           not null
#  description     :text             not null
#  completion_date :date             not null
#  is_private      :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Goal < ActiveRecord::Base
  validates :user, :title, :description, :completion_date, presence: true
  validates :is_private, inclusion: { in: [ true, false ] }

  belongs_to :user

  def is_completed?
    Date.today > self.completion_date
  end

end
