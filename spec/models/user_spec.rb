require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid without an email address" do
    user = FactoryBot.build(:user, email: nil)
    expect(user).to be_invalid
  end

  it "is invalid with duplicate email" do
    user = FactoryBot.create(:user)
    other_user = User.new(email: "tester@gmail.com")
    other_user.valid?
    expect(other_user.errors[:email]).to include("has already been taken")
  end
end
