require 'rails_helper'


RSpec.describe TweetsController, type: :controller do
    describe "Validate the Tweet controller" do
        describe "GET #index" do

            login_user
            before do
                get :index
            end
            
            it "returns http success" do
                expect(response).to have_http_status(:success)
            end
        end
    end
end