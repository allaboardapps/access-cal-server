require "rails_helper"

describe Api::V1::CalendarsController, type: :controller do
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
      let(:calendar) { FactoryGirl.create :calendar }
      let(:user) { FactoryGirl.create :user }

      before do
        authenticate_for_specs(user)
      end

      describe "#create" do
        it "creates and returns a calendar instance" do
          post(
            :create,
            name: calendar.name,
            abbreviation: calendar.abbreviation,
            time_zone: calendar.time_zone
          )
          expect_json("data", attributes: { name: calendar.name, abbreviation: calendar.abbreviation })
        end

        it "validates json attribute types" do
          post(
            :create,
            name: calendar.name,
            abbreviation: calendar.abbreviation,
            time_zone: calendar.time_zone
          )
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { name: :string })
          expect_json_types("data", attributes: { abbreviation: :string })
          expect_json_types("data", attributes: { 'time-zone': :string })
          expect_json_types("data", attributes: { archived: :boolean })
          expect_json_types("data", attributes: { test: :boolean })
          expect_json_types("data", attributes: { dummy: :boolean })
        end

        it "returns a status of 201" do
          post(
            :create,
            name: calendar.name,
            abbreviation: calendar.abbreviation,
            time_zone: calendar.time_zone
          )
          expect_status :created
        end

        it "creates a new instance" do
          expect do
            post(
              :create,
              name: Faker::Hipster.words(1)[0],
              abbreviation: Faker::Hipster.words(1)[0],
              time_zone: AllowedTimeZones::CENTRAL
            )
          end.to change(Calendar, :count).by(1)
        end
      end

      describe "#show" do
        it "returns a calendar instance" do
          get :show, id: calendar.id
          expect_json("data", attributes: { name: calendar.name, abbreviation: calendar.abbreviation })
        end

        it "validates json attribute types" do
          get :show, id: calendar.id
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { name: :string })
          expect_json_types("data", attributes: { abbreviation: :string })
          expect_json_types("data", attributes: { 'time-zone': :string })
          expect_json_types("data", attributes: { archived: :boolean })
          expect_json_types("data", attributes: { test: :boolean })
          expect_json_types("data", attributes: { dummy: :boolean })
        end

        it "returns a status of 200" do
          get :show, id: calendar.id
          expect_status :ok
        end
      end

      describe "#index" do
        it "returns a collection of calendars" do
          calendar.touch
          FactoryGirl.create :calendar
          FactoryGirl.create :calendar
          get :index
          expect_json_sizes("data", 3)
        end

        it "includes at least one of the instances" do
          calendar.touch
          calendar_2 = FactoryGirl.create :calendar
          get :index
          expect_json("data.?", attributes: { name: calendar_2.name, abbreviation: calendar_2.abbreviation })
        end

        it "returns a status of 200" do
          calendar.touch
          get :index
          expect_status :ok
        end
      end

      describe "#update" do
        it "updates the calendar" do
          put :update, id: calendar.id, name: "New name"
          expect_json("data", attributes: { name: "New name", abbreviation: calendar.abbreviation })
        end

        it "validates the json attribute types" do
          put :update, id: calendar.id, name: "New name"
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { name: :string })
          expect_json_types("data", attributes: { abbreviation: :string })
          expect_json_types("data", attributes: { 'time-zone': :string })
          expect_json_types("data", attributes: { archived: :boolean })
          expect_json_types("data", attributes: { test: :boolean })
          expect_json_types("data", attributes: { dummy: :boolean })
        end

        it "returns a status of accepted (202)" do
          put :update, id: calendar.id, name: "New name"
          expect_status :accepted
        end
      end

      describe "#delete" do
        it "returns empty json" do
          delete :destroy, id: calendar.id
          expect_json_sizes 0
        end

        it "returns a status of accepted (202)" do
          calendar.touch
          delete :destroy, id: calendar.id
          expect_status :accepted
        end

        it "deletes the specified instance" do
          calendar.touch
          expect { delete :destroy, id: calendar.id }.to change(Calendar, :count).by(-1)
        end
      end
    end
  end
end
