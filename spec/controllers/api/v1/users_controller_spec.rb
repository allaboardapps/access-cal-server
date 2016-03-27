require "rails_helper"

describe Api::V1::UsersController, type: :controller do
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
      before do
        @user = FactoryGirl.create :user
        authenticate_for_specs(@user)
      end

      describe "#create" do
        it "creates and returns an user instance" do
          post :create, first_name: @user.first_name, last_name: @user.last_name, email: Faker::Internet.email, zip_code: @user.zip_code,
            time_zone: @user.time_zone, location_id: @user.location_id, roles: @user.roles,
            statuses: @user.statuses, admin_notes: @user.admin_notes, password: "xxxxxxxxxxxxx"
          expect_json_sizes 0
        end

        it "returns a status of 201" do
          post :create, first_name: @user.first_name, last_name: @user.last_name, email: Faker::Internet.email, zip_code: @user.zip_code,
            time_zone: @user.time_zone, location_id: @user.location_id, roles: @user.roles,
            statuses: @user.statuses, admin_notes: @user.admin_notes, password: "xxxxxxxxxxxxx"
          expect_status :created
        end

        it "does not create a new instance with duplicate email" do
          expect {
            post :create, first_name: @user.first_name, last_name: @user.last_name, email: @user.email, zip_code: @user.zip_code,
              time_zone: @user.time_zone, location_id: @user.location_id, roles: @user.roles,
              statuses: @user.statuses, admin_notes: @user.admin_notes, password: "xxxxxxxxxxxxx"
          }.to raise_error(ActiveRecord::RecordNotUnique)
        end
      end

      describe "#show" do
        it "returns an user instance" do
          get :show, id: @user.id
          expect_json("data", { attributes: { first_name: @user.first_name, email: @user.email } } )
        end

        it "validates json attribute types" do
          get :show, id: @user.id
          expect_json_types("data", id: :string )
          expect_json_types("data", attributes: { token: :string_or_null } )
          expect_json_types("data", attributes: { first_name: :string } )
          expect_json_types("data", attributes: { last_name: :string } )
          expect_json_types("data", attributes: { email: :string } )
          expect_json_types("data", attributes: { zip_code: :string } )
          expect_json_types("data", attributes: { time_zone: :string } )
          expect_json_types("data", attributes: { location_id: :string } )
          expect_json_types("data", attributes: { roles: :array } )
          expect_json_types("data", attributes: { statuses: :array } )
          expect_json_types("data", attributes: { archived: :boolean } )
          expect_json_types("data", attributes: { test: :boolean } )
          expect_json_types("data", attributes: { updated_at: :date } )
          expect_json_types("data", attributes: { created_at: :date } )
        end

        it "returns a status of 200" do
          get :show, id: @user.id
          expect_status :ok
        end
      end

      describe "#index" do
        it "returns a collection of users" do
          @user_2 = FactoryGirl.create :user
          @user_3 = FactoryGirl.create :user
          get :index
          expect_json_sizes("data", 3)
        end

        it "includes at least one of the instances" do
          @user_2 = FactoryGirl.create :user
          @user_3 = FactoryGirl.create :user
          get :index
          expect_json("data.?", attributes: { first_name: @user_2.first_name, email: @user_2.email } )
        end

        it "returns a status of 200" do
          @user_2 = FactoryGirl.create :user
          @user_3 = FactoryGirl.create :user
          get :index
          expect_status :ok
        end
      end

      describe "#update" do
        it "updates the user" do
          put :update, id: @user.id, last_name: "New name"
          expect_json("data", attributes: { last_name: "New name", email: @user.email } )
        end

        it "validates the json attribute types" do
          put :update, id: @user.id, last_name: "New name"
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { token: :string_or_null } )
          expect_json_types("data", attributes: { first_name: :string } )
          expect_json_types("data", attributes: { last_name: :string } )
          expect_json_types("data", attributes: { email: :string } )
          expect_json_types("data", attributes: { zip_code: :string } )
          expect_json_types("data", attributes: { time_zone: :string } )
          expect_json_types("data", attributes: { location_id: :string } )
          expect_json_types("data", attributes: { roles: :array } )
          expect_json_types("data", attributes: { statuses: :array } )
          expect_json_types("data", attributes: { archived: :boolean } )
          expect_json_types("data", attributes: { test: :boolean } )
          expect_json_types("data", attributes: { updated_at: :date } )
          expect_json_types("data", attributes: { created_at: :date } )
        end

        it "returns a status of accepted (202)" do
          put :update, id: @user.id, last_name: "New name"
          expect_status :accepted
        end
      end

      describe "#delete" do
        it "returns empty json" do
          delete :destroy, id: @user.id
          expect_json_sizes 0
        end

        it "returns a status of accepted (202)" do
          delete :destroy, id: @user.id
          expect_status :accepted
        end

        it "deletes the specified instance" do
          expect { delete :destroy, id: @user.id }.to change(User, :count).by(-1)
        end
      end
    end
  end
end
