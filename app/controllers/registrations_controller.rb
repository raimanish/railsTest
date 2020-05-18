class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    if resource.save
      render json: resource, status: 201
    else
      render json:{
        error: resource.errors.full_messages.join(', ')
      },
      status: 422
    end
    
  end

  protected

  def sign_up_params
  	 params.require(:user).permit(:email, :password, :password_confirmation, :organization_id)
  end

end