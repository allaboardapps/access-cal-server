require "rails_helper"

describe Api::V1::CalendarUsersController, type: :controller do
  describe "accepting requests" do
    context "with incorrect token" do
      before do
        request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials("1234")
      end

      it "returns an forbidden status code" do
        calendar = FactoryGirl.create :calendar
        user = FactoryGirl.create :client
        role = CalendarRoles.all.sample
        post :create, calendar_id: calendar.id, user_id: user.id, role: role
        expect_status :forbidden
      end
    end

    context "with correct token" do
      let(:calendar) { FactoryGirl.create :calendar }
      let(:user) { FactoryGirl.create :client }
      let(:calendar_user) { FactoryGirl.create :calendar_user }
      let(:role) { CalendarRoles.all.sample }

      before do
        authenticate_for_specs(user)
      end

      describe "#create" do
        it "creates and returns an calendar_user instance" do
          post :create, user_id: user.id, calendar_id: calendar.id, role: role
          expect_json("data", attributes: { 'user-id': user.id, 'calendar-id': calendar.id, role: role })
        end

        it "validates json attribute types" do
          post :create, user_id: user.id, calendar_id: calendar.id, role: role
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { 'user-id': :string })
          expect_json_types("data", attributes: { 'calendar-id': :string })
          expect_json_types("data", attributes: { role: :string })
        end

        it "returns a status of 201" do
          post :create, user_id: user.id, calendar_id: calendar.id, role: role
          expect_status :created
        end

        it "creates a new instance for a different user" do
          calendar_user.touch
          expect do
            post :create, user_id: user.id, calendar_id: calendar_user.calendar_id, role: calendar_user.role
          end.to change(CalendarUser, :count).by(1)
        end

        it "does not create a duplicate instance, but does return the matching instance" do
          calendar_user.touch
          post :create, user_id: calendar_user.user_id, calendar_id: calendar_user.calendar_id, role: calendar_user.role
          expect_json("data", id: calendar_user.id, attributes: { 'user-id': calendar_user.user_id, 'calendar-id': calendar_user.calendar_id, role: calendar_user.role })
        end

        it "does not create duplicates" do
          calendar_user.touch
          expect do
            post :create, user_id: calendar_user.user_id, calendar_id: calendar_user.calendar_id, role: calendar_user.role
          end.to change(EventUser, :count).by(0)
        end
      end

      describe "#delete" do
        it "returns empty json" do
          delete :destroy, id: calendar_user.id
          expect_json_sizes 0
        end

        it "returns a status of accepted (202)" do
          delete :destroy, id: calendar_user.id
          expect_status :accepted
        end

        it "deletes the specified instance" do
          calendar_user.touch
          expect do
            delete :destroy, id: calendar_user.id
          end.to change(CalendarUser, :count).by(-1)
        end
      end
    end
  end
end
