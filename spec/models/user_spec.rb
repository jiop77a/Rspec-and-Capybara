# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryGirl.build(:user) }

  describe "password_digest" do
    it "sets a password_digest automatically" do
      expect(user.password_digest).to_not be_nil
    end
  end

  describe "::find_by_credentials" do
    before(:each) { user.save }

    it "returns the user if the password matches the digest" do
      found_user = User.find_by_credentials(user.user_name,
                                            user.password)
      expect(found_user).to_not be_nil
      expect(found_user.password_digest).to eq(user.password_digest)
      expect(found_user.user_name).to eq(user.user_name)
    end

    it "otherwise returns nil" do
      found_user = User.find_by_credentials(user.user_name, "password")
      expect(found_user).to be_nil
    end
  end

  describe "validations" do
    it { should validate_presence_of(:user_name) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_length_of(:password).
        is_at_least(6).
        on(:save) }
    it { should validate_uniqueness_of(:user_name) }
  end
end
