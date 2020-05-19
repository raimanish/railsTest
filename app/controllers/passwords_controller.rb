class PasswordsController < Devise::PasswordsController
    respond_to :json

    def create
        self.resource = resource_class.send_reset_password_instructions(resource_params)
        yield resource if block_given?
    
        if successfully_sent?(resource)
            render json:{
                message: 'Mail send Successfully'
            },
              status: 200       
         else
            render json:{
                error: resource.errors.full_messages.join(', ')
              },
            status: 422
        end
    end


    def update
        puts resource_params
        self.resource = resource_class.reset_password_by_token(resource_params)
        yield resource if block_given?
        
        puts resource.errors.full_messages
        if resource.errors.empty?
            render json:{
                message: 'passowrd updated successfully'
            },
            status: 200    
        else
            render json:{
                error: resource.errors.full_messages.join(', ')
              },
            status: 422
        end
    end
    
    
end