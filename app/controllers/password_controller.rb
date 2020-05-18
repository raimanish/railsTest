class PasswordController < ApplicationController
    def create
        @user = User.find_by_email(params[:user][:email])
        if @user
            @user.send_reset_password_instructions
            render json: 'Mail send successfully', status: :ok
        else
            render json: 'User does not exist', status: :unprocessable_entity
        end
    end
end