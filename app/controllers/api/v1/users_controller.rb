module Api
  module V1
    class UsersController < BaseController

      def show
        super
      end

      def create
        super
      end

      def update
        super
      end

      def destroy
        super
      end

      def user_params
        params.permit(
          :phone_number,
          :email,
          :name,
          :password,
          :status,
          :password_confirmation
        )
      end

      def query_params
        params.permit(:status)
      end
    end
  end
end
