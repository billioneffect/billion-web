require 'rails_helper'

RSpec.describe ProjectApplicationsController, :type => :controller do

  xdescribe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe "GET create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end
