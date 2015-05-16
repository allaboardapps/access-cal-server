require "rails_helper"

describe Api::V1::UsersController, type: :controller do

  describe "handling AccessDenied exceptions" do
    let(:user) { FactoryGirl.create :user }

    before do
      user.generate_token!
    end

    context "incorrect token" do
      before do
        request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials("1234")
      end

      it "returns 'Not Authorized' message" do
        get :show, id: user.id
        expect(response.body).to match /Not Authorized/
      end

      it "returns an unauthorized status code" do
        get :show, id: user.id
        expect(response.status).to eq 403
      end
    end

    context "correct token" do
      before do
        request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.token, { email: user.email })
      end

      it "returns a user name" do
        get :show, id: user.id
        expect(JSON.parse(response.body)["user"]["first_name"]).to eq user.first_name
      end

      it "returns a status of 200" do
        get :show, id: user.id
        expect(response.status).to eq 200
      end
    end
  end
end
