require 'rails_helper'

RSpec.describe User, type: :model do
  
  # ========================= Validate Role Name  Method ================================

  describe "should_create_role" do

  	describe "validate User roles" do

        before do
            @role = create(:role)
			@user =  create(:user)
		end

        it "should return true user roles" do
            expect(@user.roles_name.length).to eq(1)
        end

        it "should return true if user roles" do
			expect(@user.roles_name).to include('USER')
        end

        it "should return true if for admin roles" do
            @role = create(:role, name: 'ADMIN')
            @user.roles << @role
            expect(@user.roles_name.length).to eq(2)
			expect(@user.roles_name).to include('ADMIN')
        end

        it "User is invalid without organization" do
            @new_user = User.new(email: 'test@gmail.com', password: 'test@123');
            expect(@new_user).to_not be_valid
        end
  	end
  end
end
