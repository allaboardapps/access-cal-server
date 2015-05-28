require "rails_helper"

describe Api::V1::EventsController, type: :controller do

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
        event = FactoryGirl.create :event
        get :show, id: event.id
        expect(response.body).to match /Not Authorized/
      end

      it "returns an unauthorized status code" do
        event = FactoryGirl.create :event
        get :show, id: event.id
        expect_status :forbidden
      end
    end

    context "correct token" do
      before do
        request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.token, { email: user.email })
        @event = FactoryGirl.build :event
      end

      describe "#create" do
        it "returns a user name" do
          post :create, client_id: @event.client_id, location_id: @event.location_id, name: @event.name,
            abbreviation: @event.abbreviation, primary_category: @event.primary_category, categories: @event.categories,
            starts_at: @event.starts_at, ends_at: @event.ends_at, description: @event.description,
            street_address: @event.street_address, secondary_address: @event.secondary_address,
            city: @event.city, state: @event.state, country: @event.country, zip_code: @event.zip_code,
            time_zone: @event.time_zone, latitude: @event.latitude, longitude: @event.longitude,
            admin_notes: @event.admin_notes
          expect_json("event", { name: @event.name, description: @event.description })
        end

        it "validates json attribute types" do
          post :create, client_id: @event.client_id, location_id: @event.location_id, name: @event.name,
            abbreviation: @event.abbreviation, primary_category: @event.primary_category, categories: @event.categories,
            starts_at: @event.starts_at, ends_at: @event.ends_at, description: @event.description,
            street_address: @event.street_address, secondary_address: @event.secondary_address,
            city: @event.city, state: @event.state, country: @event.country, zip_code: @event.zip_code,
            time_zone: @event.time_zone, latitude: @event.latitude, longitude: @event.longitude,
            admin_notes: @event.admin_notes
          expect_json_types("event", { id: :integer })
          expect_json_types("event", { location_id: :integer })
          expect_json_types("event", { name: :string })
          expect_json_types("event", { abbreviation: :string })
          expect_json_types("event", { description: :string })
          expect_json_types("event", { street_address: :string })
          expect_json_types("event", { secondary_address: :string_or_null })
          expect_json_types("event", { city: :string })
          expect_json_types("event", { state: :string })
          expect_json_types("event", { country: :string })
          expect_json_types("event", { zip_code: :string })
          expect_json_types("event", { time_zone: :string })
          expect_json_types("event", { latitude: :float })
          expect_json_types("event", { longitude: :float })
          expect_json_types("event", { starts_at: :date })
          expect_json_types("event", { ends_at: :date })
          expect_json_types("event", { archived: :boolean })
          expect_json_types("event", { test: :boolean })
          expect_json_types("event", { created_at: :date })
          expect_json_types("event", { updated_at: :date })
        end

        it "returns a status of 201" do
          post :create, client_id: @event.client_id, location_id: @event.location_id, name: @event.name,
            abbreviation: @event.abbreviation, primary_category: @event.primary_category, categories: @event.categories,
            starts_at: @event.starts_at, ends_at: @event.ends_at, description: @event.description,
            street_address: @event.street_address, secondary_address: @event.secondary_address,
            city: @event.city, state: @event.state, country: @event.country, zip_code: @event.zip_code,
            time_zone: @event.time_zone, latitude: @event.latitude, longitude: @event.longitude,
            admin_notes: @event.admin_notes
          expect_status :created
        end

        it "creates a new instance" do
          @event.save
          expect { post :create, client_id: @event.client_id, location_id: @event.location_id, name: @event.name,
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
        it "returns an event name" do
          @event.save
          get :show, id: @event.id
          expect_json("event", { name: @event.name, description: @event.description })
        end

        it "validates json attribute types" do
          @event.save
          get :show, id: @event.id
          expect_json_types("event", { id: :integer })
          expect_json_types("event", { location_id: :integer })
          expect_json_types("event", { name: :string })
          expect_json_types("event", { abbreviation: :string })
          expect_json_types("event", { description: :string })
          expect_json_types("event", { street_address: :string })
          expect_json_types("event", { secondary_address: :string_or_null })
          expect_json_types("event", { city: :string })
          expect_json_types("event", { state: :string })
          expect_json_types("event", { country: :string })
          expect_json_types("event", { zip_code: :string })
          expect_json_types("event", { time_zone: :string })
          expect_json_types("event", { latitude: :float })
          expect_json_types("event", { longitude: :float })
          expect_json_types("event", { starts_at: :date })
          expect_json_types("event", { ends_at: :date })
          expect_json_types("event", { archived: :boolean })
          expect_json_types("event", { test: :boolean })
          expect_json_types("event", { created_at: :date })
          expect_json_types("event", { updated_at: :date })
        end

        it "returns a status of 200" do
          @event.save
          get :show, id: @event.id
          expect_status :ok
        end
      end

      describe "#index" do
        it "returns a collection of events" do
          @event.save
          @event_2 = FactoryGirl.create :event
          @event_3 = FactoryGirl.create :event
          get :index
          expect_json_sizes("events", 3)
        end

        it "includes at least one of the instances" do
          @event.save
          @event_2 = FactoryGirl.create :event
          @event_3 = FactoryGirl.create :event
          get :index
          expect_json("events.?", { name: @event_2.name, description: @event_2.description })
        end

        it "returns a status of 200" do
          @event.save
          @event_2 = FactoryGirl.create :event
          @event_3 = FactoryGirl.create :event
          get :index
          expect_status :ok
        end
      end

      describe "#update" do
        it "updates the event" do
          @event.save
          put :update, id: @event.id, name: "New name"
          expect_json("event", { name: "New name", description: @event.description })
        end

        it "validates the json attribute types" do
          @event.save
          put :update, id: @event.id, name: "New name"
          expect_json_types("event", { id: :integer })
          expect_json_types("event", { location_id: :integer })
          expect_json_types("event", { name: :string })
          expect_json_types("event", { abbreviation: :string })
          expect_json_types("event", { description: :string })
          expect_json_types("event", { street_address: :string })
          expect_json_types("event", { secondary_address: :string_or_null })
          expect_json_types("event", { city: :string })
          expect_json_types("event", { state: :string })
          expect_json_types("event", { country: :string })
          expect_json_types("event", { zip_code: :string })
          expect_json_types("event", { time_zone: :string })
          expect_json_types("event", { latitude: :float })
          expect_json_types("event", { longitude: :float })
          expect_json_types("event", { starts_at: :date })
          expect_json_types("event", { ends_at: :date })
          expect_json_types("event", { archived: :boolean })
          expect_json_types("event", { test: :boolean })
          expect_json_types("event", { created_at: :date })
          expect_json_types("event", { updated_at: :date })
        end

        it "returns a status of accepted (202)" do
          @event.save
          put :update, id: @event.id, name: "New name"
          expect_status :accepted
        end
      end

      describe "#delete" do
        it "returns a user name" do
          @event.save
          delete :destroy, id: @event.id
          expect_json_sizes 0
        end

        it "returns a status of accepted (202)" do
          @event.save
          delete :destroy, id: @event.id
          expect_status :accepted
        end

        it "deletes the specified instance" do
          @event.save
          expect { delete :destroy, id: @event.id }.to change(Event, :count).by(-1)
        end
      end
    end
  end
end
