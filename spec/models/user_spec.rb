require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'have db columns' do
    db_columns = %i[phone_number name status]
    db_columns.each do |column|
      it { should have_db_column(column) }
    end
  end

  describe 'parameters' do
    required_params = %i[name email password]
    required_params.each do |param|
      it { should validate_presence_of(param) }
    end
  end

  it 'should accept valid email addresses' do
    valid_emails = %w[user@mail.com a+b@mail.co ex123@x.y.co first.last@xyz.mk]
    valid_emails.each do |email|
      expect(FactoryGirl.build(:user, email: email)).to be_valid
    end
  end

  it 'should reject invalid email addresses' do
    invalid_emails = %w[user@use,com email.addr example@mail..mk user@ex_ml.org]
    invalid_emails.each do |email|
      expect(FactoryGirl.build(:user, email: email)).not_to be_valid
    end
  end

  describe 'validations' do
    subject { create(:user) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end
end
