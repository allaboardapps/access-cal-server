require "rails_helper"

describe Api::V1::OrganizationUsersController, type: :controller do
  describe "accepting requests" do
    context "with incorrect token" do
      before do
        request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials("1234")
      end

      it "returns an forbidden status code" do
        organization = FactoryGirl.create :organization
        user = FactoryGirl.create :client
        role = OrganizationRoles.all.sample
        post :create, organization_id: organization.id, user_id: user.id, role: role
        expect_status :forbidden
      end
    end

    context "with correct token" do
      let(:organization) { FactoryGirl.create :organization }
      let(:user) { FactoryGirl.create :client }
      let(:organization_user) { FactoryGirl.create :organization_user }
      let(:role) { OrganizationRoles.all.sample }

      before do
        authenticate_for_specs(user)
      end

      describe "#create" do
        it "creates and returns an organization_user instance" do
          post :create, user_id: user.id, organization_id: organization.id, role: role
          expect_json("data", attributes: { 'user-id': user.id, 'organization-id': organization.id, role: role })
        end

        it "validates json attribute types" do
          post :create, user_id: user.id, organization_id: organization.id, role: role
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { 'user-id': :string })
          expect_json_types("data", attributes: { 'organization-id': :string })
          expect_json_types("data", attributes: { role: :string })
        end

        it "returns a status of 201" do
          post :create, user_id: user.id, organization_id: organization.id, role: role
          expect_status :created
        end

        it "creates a new instance for a different user" do
          organization_user.touch
          expect do
            post :create, user_id: user.id, organization_id: organization_user.organization_id, role: organization_user.role
          end.to change(OrganizationUser, :count).by(1)
        end

        it "does not create a duplicate instance, but does return the matching instance" do
          organization_user.touch
          post :create, user_id: organization_user.user_id, organization_id: organization_user.organization_id, role: organization_user.role
          expect_json("data", id: organization_user.id, attributes: { 'user-id': organization_user.user_id, 'organization-id': organization_user.organization_id, role: organization_user.role })
        end

        it "does not create duplicates" do
          organization_user.touch
          expect do
            post :create, user_id: organization_user.user_id, organization_id: organization_user.organization_id, role: organization_user.role
          end.to change(OrganizationUser, :count).by(0)
        end
      end

      describe "#delete" do
        it "returns empty json" do
          delete :destroy, id: organization_user.id
          expect_json_sizes 0
        end

        it "returns a status of accepted (202)" do
          delete :destroy, id: organization_user.id
          expect_status :accepted
        end

        it "deletes the specified instance" do
          organization_user.touch
          expect do
            delete :destroy, id: organization_user.id
          end.to change(OrganizationUser, :count).by(-1)
        end
      end
    end
  end
end
