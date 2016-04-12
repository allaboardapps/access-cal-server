require "rails_helper"

describe Api::V1::EventUsersController, type: :controller do
  describe "accepting requests" do
    context "with incorrect token" do
      before do
        request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials("1234")
      end

      it "returns an forbidden status code" do
        event = FactoryGirl.create :event
        user = FactoryGirl.create :client
        role = EventRoles.all.sample
        post :create, event_id: event.id, user_id: user.id, role: role
        expect_status :forbidden
      end
    end

    context "with correct token" do
      let(:event) { FactoryGirl.create :event }
      let(:user) { FactoryGirl.create :client }
      let(:event_user) { FactoryGirl.create :event_user }
      let(:role) { EventRoles.all.sample }

      before do
        authenticate_for_specs(user)
      end

      describe "#create" do
        it "creates and returns an event_user instance" do
          post :create, user_id: user.id, event_id: event.id, role: role
          expect_json("data", attributes: { user_id: user.id, event_id: event.id, role: role })
        end

        it "validates json attribute types" do
          post :create, user_id: user.id, event_id: event.id, role: role
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { user_id: :string })
          expect_json_types("data", attributes: { event_id: :string })
          expect_json_types("data", attributes: { role: :string })
        end

        it "returns a status of 201" do
          post :create, user_id: user.id, event_id: event.id, role: role
          expect_status :created
        end

        it "creates a new instance for a different user" do
          event_user.touch
          expect { post :create, user_id: user.id, event_id: event_user.event_id, role: event_user.role }.to change(EventUser, :count).by(1)
        end

        it "does not create a duplicate instance, but does return the matching instance" do
          post :create, user_id: event_user.user_id, event_id: event_user.event_id, role: event_user.role
          expect_json("data", id: event_user.id, attributes: { user_id: event_user.user_id, event_id: event_user.event_id, role: event_user.role })
        end

        it "does not create duplicates" do
          event_user.touch
          expect do
            post :create, user_id: event_user.user_id, event_id: event_user.event_id, role: event_user.role
          end.to change(EventUser, :count).by(0)
        end
      end

      describe "#delete" do
        it "returns empty json" do
          delete :destroy, id: event_user.id
          expect_json_sizes 0
        end

        it "returns a status of accepted (202)" do
          delete :destroy, id: event_user.id
          expect_status :accepted
        end

        it "deletes the specified instance" do
          event_user.touch
          expect do
            delete :destroy, id: event_user.id
          end.to change(EventUser, :count).by(-1)
        end
      end
    end
  end
end
