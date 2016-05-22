require "rails_helper"

describe Api::V1::GroupUsersController, type: :controller do
  describe "accepting requests" do
    context "with incorrect token" do
      before do
        request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials("1234")
      end

      it "returns an forbidden status code" do
        group = FactoryGirl.create :group
        user = FactoryGirl.create :client
        role = GroupRoles.all.sample
        post :create, group_id: group.id, user_id: user.id, role: role
        expect_status :forbidden
      end
    end

    context "with correct token" do
      let(:group) { FactoryGirl.create :group }
      let(:user) { FactoryGirl.create :client }
      let(:group_user) { FactoryGirl.create :group_user }
      let(:role) { GroupRoles.all.sample }

      before do
        authenticate_for_specs(user)
      end

      describe "#create" do
        it "creates and returns an group_user instance" do
          post :create, user_id: user.id, group_id: group.id, role: role
          expect_json("data", attributes: { 'user-id': user.id, 'group-id': group.id, role: role })
        end

        it "validates json attribute types" do
          post :create, user_id: user.id, group_id: group.id, role: role
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { 'user-id': :string })
          expect_json_types("data", attributes: { 'group-id': :string })
          expect_json_types("data", attributes: { role: :string })
        end

        it "returns a status of 201" do
          post :create, user_id: user.id, group_id: group.id, role: role
          expect_status :created
        end

        it "creates a new instance for a different user" do
          group_user.touch
          expect do
            post :create, user_id: user.id, group_id: group_user.group_id, role: group_user.role
          end.to change(GroupUser, :count).by(1)
        end

        it "does not create a duplicate instance, but does return the matching instance" do
          group_user.touch
          post :create, user_id: group_user.user_id, group_id: group_user.group_id, role: group_user.role
          expect_json("data", id: group_user.id, attributes: { 'user-id': group_user.user_id, 'group-id': group_user.group_id, role: group_user.role })
        end

        it "does not create duplicates" do
          group_user.touch
          expect do
            post :create, user_id: group_user.user_id, group_id: group_user.group_id, role: group_user.role
          end.to change(GroupUser, :count).by(0)
        end
      end

      describe "#delete" do
        it "returns empty json" do
          delete :destroy, id: group_user.id
          expect_json_sizes 0
        end

        it "returns a status of accepted (202)" do
          delete :destroy, id: group_user.id
          expect_status :accepted
        end

        it "deletes the specified instance" do
          group_user.touch
          expect do
            delete :destroy, id: group_user.id
          end.to change(GroupUser, :count).by(-1)
        end
      end
    end
  end
end
