require 'rails_helper'


RSpec.describe TweetsController, type: :controller do
    describe "Validate the Tweet controller" do

        describe "GET #index with login" do

            login_user
            before do
                get :index
            end
            
            it "returns http success" do
                expect(response).to have_http_status(:success)
            end
        end

        describe "GET #index without login" do

            before do
                get :index
            end
            
            it "returns http unauthorised" do
                expect(response).to have_http_status(401)
            end
        end

        describe "Post #create " do

            login_user

            before do
                @organization = create(:organization)
            end
            
            it "returns http 422" do
                post :create, :params => { :tweet => { :organization_id => @organization.id } }
                expect(response).to have_http_status(422)
            end

            it "returns http success" do
                post :create, :params => { :tweet => { :message => 'This is my first tweet', :organization_id => @organization.id, user_id: subject.current_user.id } }
                expect(response).to have_http_status(:success)
            end
        end
    end
end