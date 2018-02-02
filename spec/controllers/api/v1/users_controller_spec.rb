require 'rails_helper'
RSpec.describe Api::V1::UsersController, type: :controller do

  let(:user) { FactoryGirl.create :user }

  describe 'GET #show' do
    before(:each) do
      get :show, params: {id: user.id}, format: :json
    end
    it 'should return a user' do
      user_response = json_response
      expect(user_response[:name]).to eq user.name
    end
  end

  describe 'POST #create' do
    context 'when is successfully created' do

      before(:each) do
        @create_hash = FactoryGirl.attributes_for :user
        post :create, params: @create_hash, format: :json
      end

      it 'should create a user' do
        user_response = json_response
        expect(user_response[:email]).to eql @create_hash[:email]
      end
      it { should respond_with 201 }
    end

    context 'when user is not created' do
      before(:each) do
        @invalid_hash = FactoryGirl.attributes_for(:user).except(:password)
        post :create, params: @invalid_hash
      end

      it 'renders an errors json' do
        user_response = json_response
        puts "user_response: #{user_response}"
        expect(user_response).to have_key(:errors)
      end

      it 'renders the json errors on why the user could not be created' do
        user_response = json_response
        expect(user_response[:errors][:password]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
  describe 'PUT/PATCH #update' do

    context 'when is successfully updated' do
      before(:each) do
        patch :update, params: {
          id: user.id,
          email: 'newmail@example.com',
          password_confirmation: 'password',
          password: 'password'
        }, format: :json
      end

      it 'renders the json representation for the updated user' do
        user_response = json_response
        expect(user_response[:email]).to eql 'newmail@example.com'
      end

      it { should respond_with 200 }
    end

    context 'when is not created' do
      before(:each) do
        patch :update, params: { id: user.id, email: 'bademail.com' }, format: :json
      end

      it 'renders an errors json' do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it 'renders the json errors on whye the user could not be created' do
        user_response = json_response
        expect(user_response[:errors][:email]).to include 'is invalid'
      end

      it { should respond_with 422 }
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      delete :destroy, params: { id: user.id }, format: :json
    end

    it { should respond_with 204 }

  end
end
