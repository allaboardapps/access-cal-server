require "rails_helper"

describe Api::V1::UsersController, type: :controller do

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
        get :show, id: user.id
        expect(response.body).to match /Not Authorized/
      end

      it "returns an qunauthorized status code" do
        get :show, id: user.id
        expect(response.status).to eq 403
      end
    end

    context "correct token" do
      before do
        request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.token, { email: user.email })
        @user = FactoryGirl.build :user
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

        it "does not create a new instance until confirmed" do
          expect {
            post :create, first_name: @user.first_name, last_name: @user.last_name, email: @user.email, zip_code: @user.zip_code,
              time_zone: @user.time_zone, location_id: @user.location_id, roles: @user.roles,
              statuses: @user.statuses, admin_notes: @user.admin_notes, password: "xxxxxxxxxxxxx"
          }.to change(User, :count).by(1)
        end
      end

      describe "#show" do
        it "returns an user instance" do
          @user.save
          get :show, id: @user.id
          expect_json("user", { first_name: @user.first_name, email: @user.email })
        end

        it "validates json attribute types" do
          @user.save
          get :show, id: @user.id
          expect_json_types("user", { token: :string_or_null })
          expect_json_types("user", { id: :integer })
          expect_json_types("user", { first_name: :string })
          expect_json_types("user", { last_name: :string })
          expect_json_types("user", { email: :string })
          expect_json_types("user", { zip_code: :string })
          expect_json_types("user", { time_zone: :string })
          expect_json_types("user", { location_id: :integer })
          expect_json_types("user", { roles: :array })
          expect_json_types("user", { statuses: :array })
          expect_json_types("user", { archived: :boolean })
          expect_json_types("user", { test: :boolean })
          expect_json_types("user", { updated_at: :date })
          expect_json_types("user", { created_at: :date })
        end

        it "returns a status of 200" do
          @user.save
          get :show, id: @user.id
          expect_status :ok
        end
      end

      describe "#index" do
        it "returns a collection of users" do
          @user.save
          @user_2 = FactoryGirl.create :user
          @user_3 = FactoryGirl.create :user
          get :index
          expect_json_sizes("users", 4)
        end

        it "includes at least one of the instances" do
          @user.save
          @user_2 = FactoryGirl.create :user
          @user_3 = FactoryGirl.create :user
          get :index
          expect_json("users.?", { first_name: @user_2.first_name, email: @user_2.email })
        end

        it "returns a status of 200" do
          @user.save
          @user_2 = FactoryGirl.create :user
          @user_3 = FactoryGirl.create :user
          get :index
          expect_status :ok
        end
      end

      describe "#update" do
        it "updates the user" do
          @user.save
          put :update, id: @user.id, last_name: "New name"
          expect_json("user", { last_name: "New name", email: @user.email })
        end

        it "validates the json attribute types" do
          @user.save
          put :update, id: @user.id, last_name: "New name"
          expect_json_types("user", { token: :string_or_null })
          expect_json_types("user", { id: :integer })
          expect_json_types("user", { first_name: :string })
          expect_json_types("user", { last_name: :string })
          expect_json_types("user", { email: :string })
          expect_json_types("user", { zip_code: :string })
          expect_json_types("user", { time_zone: :string })
          expect_json_types("user", { location_id: :integer })
          expect_json_types("user", { roles: :array })
          expect_json_types("user", { statuses: :array })
          expect_json_types("user", { archived: :boolean })
          expect_json_types("user", { test: :boolean })
          expect_json_types("user", { updated_at: :date })
          expect_json_types("user", { created_at: :date })
        end

        it "returns a status of accepted (202)" do
          @user.save
          put :update, id: @user.id, last_name: "New name"
          expect_status :accepted
        end
      end

      describe "#delete" do
        it "returns empty json" do
          @user.save
          delete :destroy, id: @user.id
          expect_json_sizes 0
        end

        it "returns a status of accepted (202)" do
          @user.save
          delete :destroy, id: @user.id
          expect_status :accepted
        end

        it "deletes the specified instance" do
          @user.save
          expect { delete :destroy, id: @user.id }.to change(User, :count).by(-1)
        end
      end
    end
  end
end
