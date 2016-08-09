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

require 'rails_helper'

RSpec.describe Goal, type: :model do

  describe "goal has appropriate validation" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:completion_date) }
    it { should validate_inclusion_of(:is_private).in_array([true,false]) }
    it { should belong_to(:user) }
  end

  describe "#is_completed?" do
    it "is not complete when completion_date is > today" do
      uncompleted = Goal.new(user_id: 1,
                             title: "goal",
                             description: "not complete",
                             completion_date: Date.tomorrow,
                             is_private: false)

      expect(uncompleted.is_completed?).to be_falsey
    end

    it "is complete when completion_date is < today" do
      completed = Goal.new(user_id: 1,
                           title: "goal",
                           description: "not complete",
                           completion_date: Date.yesterday,
                           is_private: false)

      expect(completed.is_completed?).to be_truthy
    end
  end

end
