require "rails_helper"

describe Api::V1::FavoritesController, type: :controller do
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
        favorite = FactoryGirl.create :favorite
        get :show, id: favorite.id
        expect(response.body).to match /Not Authorized/
      end

      it "returns an unauthorized status code" do
        favorite = FactoryGirl.create :favorite
        get :show, id: favorite.id
        expect_status :forbidden
      end
    end

    context "correct token" do
      before do
        request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.token, { email: user.email })
        @favorite = FactoryGirl.build :favorite
      end

      describe "#create" do
        it "creates and returns a favorite instance" do
          post :create, user_id: @favorite.user_id, event_id: @favorite.event_id
          expect_json("favorite", { user_id: @favorite.user_id, event_id: @favorite.event_id })
        end

        it "validates json attribute types" do
          post :create, user_id: @favorite.user_id, event_id: @favorite.event_id
          expect_json_types("favorite", { id: :integer })
          expect_json_types("favorite", { user_id: :integer })
          expect_json_types("favorite", { event_id: :integer })
          expect_json_types("favorite", { archived: :boolean })
          expect_json_types("favorite", { test: :boolean })
        end

        it "returns a status of 201" do
          post :create, user_id: @favorite.user_id, event_id: @favorite.event_id
          expect_status :created
        end

        it "creates a new instance" do
          expect {
            post :create, user_id: @favorite.user_id, event_id: @favorite.event_id
          }.to change(Favorite, :count).by(1)
        end

        it "does not create a duplicate instance, but does return the matching instance" do
          @favorite.save
          post :create, user_id: @favorite.user_id, event_id: @favorite.event_id
          expect_json("favorite", { id: @favorite.id, event_id: @favorite.event_id })
        end

        it "does not create duplicates" do
          @favorite.save
          expect {
            post :create, user_id: @favorite.user_id, event_id: @favorite.event_id
          }.to change(Favorite, :count).by(0)
        end
      end

      describe "#show" do
        it "returns a favorite instance" do
          @favorite.save
          get :show, id: @favorite.id
          expect_json("favorite", { user_id: @favorite.user_id, event_id: @favorite.event_id })
        end

        it "validates json attribute types" do
          @favorite.save
          get :show, id: @favorite.id
          expect_json_types("favorite", { id: :integer })
          expect_json_types("favorite", { user_id: :integer })
          expect_json_types("favorite", { event_id: :integer })
          expect_json_types("favorite", { archived: :boolean })
          expect_json_types("favorite", { test: :boolean })
        end

        it "returns a status of 200" do
          @favorite.save
          get :show, id: @favorite.id
          expect_status :ok
        end
      end

      describe "#index" do
        it "returns a collection of favorites" do
          @favorite.save
          @favorite_2 = FactoryGirl.create :favorite
          @favorite_3 = FactoryGirl.create :favorite
          get :index
          expect_json_sizes("favorites", 3)
        end

        it "includes at least one of the instances" do
          @favorite.save
          @favorite_2 = FactoryGirl.create :favorite
          @favorite_3 = FactoryGirl.create :favorite
          get :index
          expect_json("favorites.?", { user_id: @favorite_2.user_id, event_id: @favorite_2.event_id })
        end

        it "returns a status of 200" do
          @favorite.save
          @favorite_2 = FactoryGirl.create :favorite
          @favorite_3 = FactoryGirl.create :favorite
          get :index
          expect_status :ok
        end
      end

      describe "#update" do
        it "updates the favorite" do
          @favorite.save
          put :update, id: @favorite.id, archived: true
          expect_json("favorite", { archived: true })
        end

        it "validates the json attribute types" do
          @favorite.save
          put :update, id: @favorite.id, archived: true
          expect_json_types("favorite", { id: :integer })
          expect_json_types("favorite", { user_id: :integer })
          expect_json_types("favorite", { event_id: :integer })
          expect_json_types("favorite", { archived: :boolean })
          expect_json_types("favorite", { test: :boolean })
        end

        it "returns a status of accepted (202)" do
          @favorite.save
          put :update, id: @favorite.id, archived: true
          expect_status :accepted
        end
      end

      describe "#delete" do
        it "returns empty json" do
          @favorite.save
          delete :destroy, id: @favorite.id
          expect_json_sizes 0
        end

        it "returns a status of accepted (202)" do
          @favorite.save
          delete :destroy, id: @favorite.id
          expect_status :accepted
        end

        it "deletes the specified instance" do
          @favorite.save
          expect { delete :destroy, id: @favorite.id }.to change(Favorite, :count).by(-1)
        end
      end
    end
  end
end
