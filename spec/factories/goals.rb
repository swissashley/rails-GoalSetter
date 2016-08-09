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

FactoryGirl.define do
  factory :goal do
    
  end
end
