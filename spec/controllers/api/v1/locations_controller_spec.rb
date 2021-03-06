require "rails_helper"

describe Api::V1::LocationsController, type: :controller do
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
      let(:location) { FactoryGirl.create :location }
      let(:user) { FactoryGirl.create :user, location: location }

      before do
        authenticate_for_specs(user)
      end

      describe "#create" do
        it "creates and returns a location instance" do
          post(
            :create,
            region_id: location.region.id, name: location.name,
            abbreviation: location.abbreviation, time_zone: location.time_zone,
            admin_notes: location.admin_notes
          )
          expect_json("data", attributes: { name: location.name, abbreviation: location.abbreviation })
        end

        it "validates json attribute types" do
          post(
            :create,
            region_id: location.region.id, name: location.name,
            abbreviation: location.abbreviation, time_zone: location.time_zone,
            admin_notes: location.admin_notes
          )
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { 'region-id': :string })
          expect_json_types("data", attributes: { name: :string })
          expect_json_types("data", attributes: { abbreviation: :string })
          expect_json_types("data", attributes: { 'time-zone': :string })
          expect_json_types("data", attributes: { archived: :boolean })
          expect_json_types("data", attributes: { test: :boolean })
        end

        it "returns a status of 201" do
          post(
            :create,
            region_id: location.region.id, name: location.name,
            abbreviation: location.abbreviation, time_zone: location.time_zone,
            admin_notes: location.admin_notes
          )
          expect_status :created
        end

        it "creates a new instance" do
          expect do
            post(
              :create,
              region_id: location.region.id, name: location.name,
              abbreviation: location.abbreviation, time_zone: location.time_zone,
              admin_notes: location.admin_notes
            )
          end.to change(Location, :count).by(1)
        end
      end

      describe "#show" do
        it "returns a location instance" do
          get :show, id: location.id
          expect_json("data", attributes: { name: location.name, abbreviation: location.abbreviation })
        end

        it "validates json attribute types" do
          get :show, id: location.id
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { 'region-id': :string })
          expect_json_types("data", attributes: { name: :string })
          expect_json_types("data", attributes: { abbreviation: :string })
          expect_json_types("data", attributes: { 'time-zone': :string })
          expect_json_types("data", attributes: { archived: :boolean })
          expect_json_types("data", attributes: { test: :boolean })
        end

        it "returns a status of 200" do
          get :show, id: location.id
          expect_status :ok
        end
      end

      describe "#index" do
        it "returns a collection of locations" do
          location.touch
          FactoryGirl.create :location
          FactoryGirl.create :location
          get :index
          expect_json_sizes("data", 3)
        end

        it "includes at least one of the instances" do
          location_2 = FactoryGirl.create :location
          get :index
          expect_json("data.?", attributes: { name: location_2.name, abbreviation: location_2.abbreviation })
        end

        it "returns a status of 200" do
          location.touch
          get :index
          expect_status :ok
        end
      end

      describe "#update" do
        it "updates the location" do
          put :update, id: location.id, name: "New name"
          expect_json("data", attributes: { name: "New name", abbreviation: location.abbreviation })
        end

        it "validates the json attribute types" do
          put :update, id: location.id, name: "New name"
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { 'region-id': :string })
          expect_json_types("data", attributes: { name: :string })
          expect_json_types("data", attributes: { abbreviation: :string })
          expect_json_types("data", attributes: { 'time-zone': :string })
          expect_json_types("data", attributes: { archived: :boolean })
          expect_json_types("data", attributes: { test: :boolean })
        end

        it "returns a status of accepted (202)" do
          put :update, id: location.id, name: "New name"
          expect_status :accepted
        end
      end

      describe "#delete" do
        it "returns empty json" do
          delete :destroy, id: location.id
          expect_json_sizes 0
        end

        it "returns a status of accepted (202)" do
          delete :destroy, id: location.id
          expect_status :accepted
        end

        it "deletes the specified instance" do
          expect { delete :destroy, id: location.id }.to change(Location, :count).by(-1)
        end
      end
    end
  end
end
