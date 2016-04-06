require "rails_helper"

describe Api::V1::EventsController, type: :controller do
  describe "accepting requests" do
    context "with incorrect token" do
      before do
        request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials("1234")
      end

      it "returns an unauthorized status code" do
        event = FactoryGirl.create :event
        get :show, id: event.id
        expect_status :forbidden
      end
    end

    context "with correct token" do
      before do
        @event = FactoryGirl.create :event
        @user = FactoryGirl.create :user
        authenticate_for_specs(@user)
      end

      describe "#create" do
        it "creates and returns an event instance" do
          post :create, author_id: @event.author_id, location_id: @event.location_id, name: @event.name,
            abbreviation: @event.abbreviation, primary_category: @event.primary_category, categories: @event.categories,
            starts_at: @event.starts_at, ends_at: @event.ends_at, description: @event.description,
            street_address: @event.street_address, secondary_address: @event.secondary_address,
            city: @event.city, state: @event.state, country: @event.country, zip_code: @event.zip_code,
            time_zone: @event.time_zone, latitude: @event.latitude, longitude: @event.longitude,
            admin_notes: @event.admin_notes
          expect_json("data", attributes: { name: @event.name, description: @event.description })
        end

        it "validates json attribute types" do
          post :create, author_id: @event.author_id, location_id: @event.location_id, name: @event.name,
            abbreviation: @event.abbreviation, primary_category: @event.primary_category, categories: @event.categories,
            starts_at: @event.starts_at, ends_at: @event.ends_at, description: @event.description,
            street_address: @event.street_address, secondary_address: @event.secondary_address,
            city: @event.city, state: @event.state, country: @event.country, zip_code: @event.zip_code,
            time_zone: @event.time_zone, latitude: @event.latitude, longitude: @event.longitude,
            admin_notes: @event.admin_notes
          expect_json_types("data", { id: :string })
          expect_json_types("data", attributes: { location_id: :string })
          expect_json_types("data", attributes: { name: :string })
          expect_json_types("data", attributes: { abbreviation: :string })
          expect_json_types("data", attributes: { description: :string })
          expect_json_types("data", attributes: { street_address: :string })
          expect_json_types("data", attributes: { secondary_address: :string_or_null })
          expect_json_types("data", attributes: { city: :string })
          expect_json_types("data", attributes: { state: :string })
          expect_json_types("data", attributes: { country: :string })
          expect_json_types("data", attributes: { zip_code: :string })
          expect_json_types("data", attributes: { time_zone: :string })
          expect_json_types("data", attributes: { latitude: :float })
          expect_json_types("data", attributes: { longitude: :float })
          expect_json_types("data", attributes: { starts_at: :date })
          expect_json_types("data", attributes: { ends_at: :date })
          expect_json_types("data", attributes: { archived: :boolean })
          expect_json_types("data", attributes: { test: :boolean })
          expect_json_types("data", attributes: { created_at: :date })
          expect_json_types("data", attributes: { updated_at: :date })
        end

        it "returns a status of 201" do
          post :create, author_id: @event.author_id, location_id: @event.location_id, name: @event.name,
            abbreviation: @event.abbreviation, primary_category: @event.primary_category, categories: @event.categories,
            starts_at: @event.starts_at, ends_at: @event.ends_at, description: @event.description,
            street_address: @event.street_address, secondary_address: @event.secondary_address,
            city: @event.city, state: @event.state, country: @event.country, zip_code: @event.zip_code,
            time_zone: @event.time_zone, latitude: @event.latitude, longitude: @event.longitude,
            admin_notes: @event.admin_notes
          expect_status :created
        end

        it "creates a new instance" do
          expect { post :create, author_id: @event.author_id, location_id: @event.location_id, name: @event.name,
            abbreviation: @event.abbreviation, primary_category: @event.primary_category, categories: @event.categories,
            starts_at: @event.starts_at, ends_at: @event.ends_at, description: @event.description,
            street_address: @event.street_address, secondary_address: @event.secondary_address,
            city: @event.city, state: @event.state, country: @event.country, zip_code: @event.zip_code,
            time_zone: @event.time_zone, latitude: @event.latitude, longitude: @event.longitude,
            admin_notes: @event.admin_notes
          }.to change(Event, :count).by(1)
        end
      end

      describe "#show" do
        it "returns an event instance" do
          get :show, id: @event.id
          expect_json("data", attributes: { name: @event.name, description: @event.description })
        end

        it "validates json attribute types" do
          get :show, id: @event.id
          expect_json_types("data", { id: :string })
          expect_json_types("data", attributes: { location_id: :string })
          expect_json_types("data", attributes: { name: :string })
          expect_json_types("data", attributes: { abbreviation: :string })
          expect_json_types("data", attributes: { description: :string })
          expect_json_types("data", attributes: { street_address: :string })
          expect_json_types("data", attributes: { secondary_address: :string_or_null })
          expect_json_types("data", attributes: { city: :string })
          expect_json_types("data", attributes: { state: :string })
          expect_json_types("data", attributes: { country: :string })
          expect_json_types("data", attributes: { zip_code: :string })
          expect_json_types("data", attributes: { time_zone: :string })
          expect_json_types("data", attributes: { latitude: :float })
          expect_json_types("data", attributes: { longitude: :float })
          expect_json_types("data", attributes: { starts_at: :date })
          expect_json_types("data", attributes: { ends_at: :date })
          expect_json_types("data", attributes: { archived: :boolean })
          expect_json_types("data", attributes: { test: :boolean })
          expect_json_types("data", attributes: { created_at: :date })
          expect_json_types("data", attributes: { updated_at: :date })
        end

        it "returns a status of 200" do
          get :show, id: @event.id
          expect_status :ok
        end
      end

      describe "#index" do
        it "returns a collection of events" do
          @event_2 = FactoryGirl.create :event
          @event_3 = FactoryGirl.create :event
          get :index
          expect_json_sizes("data", 3)
        end

        it "includes at least one of the instances" do
          @event_2 = FactoryGirl.create :event
          @event_3 = FactoryGirl.create :event
          get :index
          expect_json("data.?", attributes: { name: @event_2.name, description: @event_2.description })
        end

        it "returns a status of 200" do
          @event_2 = FactoryGirl.create :event
          @event_3 = FactoryGirl.create :event
          get :index
          expect_status :ok
        end
      end

      describe "#update" do
        it "updates the event" do
          put :update, id: @event.id, name: "New name"
          expect_json("data", attributes: { name: "New name", description: @event.description })
        end

        it "validates the json attribute types" do
          put :update, id: @event.id, name: "New name"
          expect_json_types("data", { id: :string })
          expect_json_types("data", attributes: { location_id: :string })
          expect_json_types("data", attributes: { name: :string })
          expect_json_types("data", attributes: { abbreviation: :string })
          expect_json_types("data", attributes: { description: :string })
          expect_json_types("data", attributes: { street_address: :string })
          expect_json_types("data", attributes: { secondary_address: :string_or_null })
          expect_json_types("data", attributes: { city: :string })
          expect_json_types("data", attributes: { state: :string })
          expect_json_types("data", attributes: { country: :string })
          expect_json_types("data", attributes: { zip_code: :string })
          expect_json_types("data", attributes: { time_zone: :string })
          expect_json_types("data", attributes: { latitude: :float })
          expect_json_types("data", attributes: { longitude: :float })
          expect_json_types("data", attributes: { starts_at: :date })
          expect_json_types("data", attributes: { ends_at: :date })
          expect_json_types("data", attributes: { archived: :boolean })
          expect_json_types("data", attributes: { test: :boolean })
          expect_json_types("data", attributes: { created_at: :date })
          expect_json_types("data", attributes: { updated_at: :date })
        end

        it "returns a status of accepted (202)" do
          put :update, id: @event.id, name: "New name"
          expect_status :accepted
        end
      end

      describe "#delete" do
        it "returns empty json" do
          delete :destroy, id: @event.id
          expect_json_sizes 0
        end

        it "returns a status of accepted (202)" do
          delete :destroy, id: @event.id
          expect_status :accepted
        end

        it "deletes the specified instance" do
          expect { delete :destroy, id: @event.id }.to change(Event, :count).by(-1)
        end
      end
    end
  end
end
