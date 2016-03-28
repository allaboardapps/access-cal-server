require "rails_helper"

describe Api::V1::SessionsController, type: :controller do
  describe "handling AccessDenied exceptions" do
    let(:user) { FactoryGirl.create :user }

    context "invalid credentials" do
      before do
        request.accept = "application/vnd.api+json"
      end

      it "returns 'Not Authorized' message" do
        post :create, email: user.email, password: "xxxx"
        expect(response.body).to be_empty
      end

      it "returns an unauthorized status code" do
        post :create, email: user.email, password: "xxxx"
        expect_status :forbidden
      end
    end

    context "valid credentials" do
      before do
        request.accept = "application/vnd.api+json"
      end

      it "returns a user token that already exists on model" do
        user.update_attribute(:token, "1234")
        post :create, email: user.email, password: user.password
        expect_json("data", attributes: { token: "1234" })
      end

      it "creates a user token if not present previously" do
        user.update_attribute(:token, nil)
        post :create, email: user.email, password: user.password
        expect_json("data", attributes: { token: user.reload.token })
      end

      it "validates json attribute types" do
        user.update_attribute(:token, nil)
        post :create, email: user.email, password: user.password
        expect_json_types("data", attributes: { token: :string })
        expect_json_types("data", { id: :string })
        expect_json_types("data", attributes: { first_name: :string })
        expect_json_types("data", attributes: { last_name: :string })
        expect_json_types("data", attributes: { email: :string })
        expect_json_types("data", attributes: { zip_code: :string })
        expect_json_types("data", attributes: { time_zone: :string })
        expect_json_types("data", attributes: { location_id: :string })
        expect_json_types("data", attributes: { roles: :array })
        expect_json_types("data", attributes: { statuses: :array })
        expect_json_types("data", attributes: { archived: :boolean })
        expect_json_types("data", attributes: { test: :boolean })
        expect_json_types("data", attributes: { updated_at: :date })
        expect_json_types("data", attributes: { created_at: :date })
      end

      it "returns a status of 200" do
        get :create, email: user.email, password: user.password
        expect_status :ok
      end
    end
  end
end
