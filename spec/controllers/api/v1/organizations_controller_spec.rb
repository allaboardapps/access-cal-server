require "rails_helper"

describe Api::V1::OrganizationsController, type: :controller do
  describe "accepting requests" do
    context "with incorrect token" do
      before do
        request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials("1234")
      end

      it "returns an forbidden status code" do
        get :show, id: 1
        expect_status :forbidden
      end
    end

    context "with correct token" do
      let(:organization) { FactoryGirl.create :organization, name: Faker::Company.name }
      let(:user) { FactoryGirl.create :user }

      before do
        authenticate_for_specs(user)
      end

      describe "#create" do
        it "creates and returns a organization instance" do
          new_name = Faker::Company.name
          post :create, name: new_name
          expect_json("data", attributes: { name: new_name })
        end

        it "validates json attribute types" do
          post :create, name: Faker::Company.name
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { name: :string })
          expect_json_types("data", attributes: { archived: :boolean })
          expect_json_types("data", attributes: { test: :boolean })
          expect_json_types("data", attributes: { dummy: :boolean })
        end

        it "returns a status of 201" do
          post :create, name: Faker::Company.name
          expect_status :created
        end

        it "creates a new instance" do
          expect do
            post :create, name: Faker::Company.name
          end.to change(Organization, :count).by(1)
        end
      end

      describe "#show" do
        it "returns a organization instance" do
          get :show, id: organization.id
          expect_json("data", attributes: { name: organization.name })
        end

        it "validates json attribute types" do
          get :show, id: organization.id
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { name: :string })
          expect_json_types("data", attributes: { archived: :boolean })
          expect_json_types("data", attributes: { test: :boolean })
          expect_json_types("data", attributes: { dummy: :boolean })
        end

        it "returns a status of 200" do
          get :show, id: organization.id
          expect_status :ok
        end
      end

      describe "#index" do
        it "returns a collection of organizations" do
          organization.touch
          FactoryGirl.create :organization
          FactoryGirl.create :organization
          get :index
          expect_json_sizes("data", 3)
        end

        it "includes at least one of the instances" do
          organization_2 = FactoryGirl.create :organization
          get :index
          expect_json("data.?", attributes: { name: organization_2.name })
        end

        it "returns a status of 200" do
          FactoryGirl.create :organization
          FactoryGirl.create :organization
          get :index
          expect_status :ok
        end
      end

      describe "#update" do
        it "updates the organization" do
          organization.touch
          new_name = Faker::Company.name
          put :update, id: organization.id, name: new_name
          expect_json("data", attributes: { name: new_name })
        end

        it "validates the json attribute types" do
          put :update, id: organization.id, name: Faker::Company.name
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { name: :string })
          expect_json_types("data", attributes: { archived: :boolean })
          expect_json_types("data", attributes: { test: :boolean })
          expect_json_types("data", attributes: { dummy: :boolean })
        end

        it "returns a status of accepted (202)" do
          put :update, id: organization.id, name: "New name"
          expect_status :accepted
        end
      end

      describe "#delete" do
        it "returns empty json" do
          organization.touch
          delete :destroy, id: organization.id
          expect_json_sizes 0
        end

        it "returns a status of accepted (202)" do
          organization.touch
          delete :destroy, id: organization.id
          expect_status :accepted
        end

        it "deletes the specified instance" do
          organization.touch
          expect { delete :destroy, id: organization.id }.to change(Organization, :count).by(-1)
        end
      end
    end
  end
end
