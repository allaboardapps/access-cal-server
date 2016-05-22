require "rails_helper"

describe Api::V1::FavoritesController, type: :controller do
  describe "accepting requests" do
    context "with incorrect token" do
      before do
        request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials("1234")
      end

      it "returns an forbidden status code" do
        favorite = FactoryGirl.create :favorite
        get :show, id: favorite.id
        expect_status :forbidden
      end
    end

    context "with correct token" do
      let(:favorite) { FactoryGirl.create :favorite }
      let(:user) { FactoryGirl.create :user }

      before do
        authenticate_for_specs(user)
      end

      describe "#create" do
        it "creates and returns a favorite instance" do
          post :create, user_id: favorite.user_id, event_id: favorite.event_id
          expect_json("data", attributes: { 'user-id': favorite.user_id, 'event-id': favorite.event_id })
        end

        it "validates json attribute types" do
          post :create, user_id: favorite.user_id, event_id: favorite.event_id
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { 'user-id': :string })
          expect_json_types("data", attributes: { 'event-id': :string })
          expect_json_types("data", attributes: { archived: :boolean })
          expect_json_types("data", attributes: { test: :boolean })
        end

        it "returns a status of 201" do
          post :create, user_id: favorite.user_id, event_id: favorite.event_id
          expect_status :created
        end

        it "creates a new instance for a different user" do
          favorite.touch
          expect { post :create, user_id: user.id, event_id: favorite.event_id }.to change(Favorite, :count).by(1)
        end

        it "does not create a duplicate instance, but does return the matching instance" do
          post :create, user_id: favorite.user_id, event_id: favorite.event_id
          expect_json("data", id: favorite.id, attributes: { 'event-id': favorite.event_id })
        end

        it "does not create duplicates" do
          favorite.touch
          expect { post :create, user_id: favorite.user_id, event_id: favorite.event_id }.to change(Favorite, :count).by(0)
        end
      end

      describe "#show" do
        it "returns a favorite instance" do
          get :show, id: favorite.id
          expect_json("data", attributes: { 'user-id': favorite.user_id, 'event-id': favorite.event_id })
        end

        it "validates json attribute types" do
          get :show, id: favorite.id
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { 'user-id': :string })
          expect_json_types("data", attributes: { 'event-id': :string })
          expect_json_types("data", attributes: { archived: :boolean })
          expect_json_types("data", attributes: { test: :boolean })
        end

        it "returns a status of 200" do
          get :show, id: favorite.id
          expect_status :ok
        end
      end

      describe "#index" do
        it "returns a collection of favorites" do
          FactoryGirl.create :favorite
          FactoryGirl.create :favorite
          get :index
          expect_json_sizes("data", 2)
        end

        it "includes at least one of the instances" do
          favorite_2 = FactoryGirl.create :favorite
          get :index
          expect_json("data.?", attributes: { 'user-id': favorite_2.user_id, 'event-id': favorite_2.event_id })
        end

        it "returns a status of 200" do
          FactoryGirl.create :favorite
          FactoryGirl.create :favorite
          get :index
          expect_status :ok
        end
      end

      describe "#update" do
        it "updates the favorite" do
          put :update, id: favorite.id, archived: true
          expect_json("data", attributes: { archived: true })
        end

        it "validates the json attribute types" do
          put :update, id: favorite.id, archived: true
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { 'user-id': :string })
          expect_json_types("data", attributes: { 'event-id': :string })
          expect_json_types("data", attributes: { archived: :boolean })
          expect_json_types("data", attributes: { test: :boolean })
        end

        it "returns a status of accepted (202)" do
          put :update, id: favorite.id, archived: true
          expect_status :accepted
        end
      end

      describe "#delete" do
        it "returns empty json" do
          delete :destroy, id: favorite.id
          expect_json_sizes 0
        end

        it "returns a status of accepted (202)" do
          delete :destroy, id: favorite.id
          expect_status :accepted
        end

        it "deletes the specified instance" do
          favorite.touch
          expect { delete :destroy, id: favorite.id }.to change(Favorite, :count).by(-1)
        end
      end
    end
  end
end
