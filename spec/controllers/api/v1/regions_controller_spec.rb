require "rails_helper"

describe Api::V1::RegionsController, type: :controller do
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
        region = FactoryGirl.create :region
        get :show, id: region.id
        expect(response.body).to match /Not Authorized/
      end

      it "returns an unauthorized status code" do
        region = FactoryGirl.create :region
        get :show, id: region.id
        expect_status :forbidden
      end
    end

    context "correct token" do
      before do
        request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.token, { email: user.email })
        @region = FactoryGirl.build :region
      end

      describe "#create" do
        it "creates and returns a region instance" do
          post :create, name: @region.name,
            abbreviation: @region.abbreviation, time_zone: @region.time_zone,
            admin_notes: @region.admin_notes
          expect_json("region", { name: @region.name, abbreviation: @region.abbreviation })
        end

        it "validates json attribute types" do
          post :create, name: @region.name,
            abbreviation: @region.abbreviation, time_zone: @region.time_zone,
            admin_notes: @region.admin_notes
          expect_json_types("region", { id: :integer })
          expect_json_types("region", { name: :string })
          expect_json_types("region", { abbreviation: :string })
          expect_json_types("region", { time_zone: :string })
          expect_json_types("region", { archived: :boolean })
          expect_json_types("region", { test: :boolean })
        end

        it "returns a status of 201" do
          post :create, name: @region.name,
            abbreviation: @region.abbreviation, time_zone: @region.time_zone,
            admin_notes: @region.admin_notes
          expect_status :created
        end

        it "creates a new instance" do
          expect { post :create, name: @region.name,
            abbreviation: @region.abbreviation, time_zone: @region.time_zone,
            admin_notes: @region.admin_notes
          }.to change(Region, :count).by(1)
        end
      end

      describe "#show" do
        it "returns a region instance" do
          @region.save
          get :show, id: @region.id
          expect_json("region", { name: @region.name, abbreviation: @region.abbreviation })
        end

        it "validates json attribute types" do
          @region.save
          get :show, id: @region.id
          expect_json_types("region", { id: :integer })
          expect_json_types("region", { name: :string })
          expect_json_types("region", { abbreviation: :string })
          expect_json_types("region", { time_zone: :string })
          expect_json_types("region", { archived: :boolean })
          expect_json_types("region", { test: :boolean })
        end

        it "returns a status of 200" do
          @region.save
          get :show, id: @region.id
          expect_status :ok
        end
      end

      describe "#index" do
        it "returns a collection of regions" do
          @region.save
          @region_2 = FactoryGirl.create :region
          @region_3 = FactoryGirl.create :region
          get :index
          expect_json_sizes("regions", 4)
        end

        it "includes at least one of the instances" do
          @region.save
          @region_2 = FactoryGirl.create :region
          @region_3 = FactoryGirl.create :region
          get :index
          expect_json("regions.?", { name: @region_2.name, abbreviation: @region_2.abbreviation })
        end

        it "returns a status of 200" do
          @region.save
          @region_2 = FactoryGirl.create :region
          @region_3 = FactoryGirl.create :region
          get :index
          expect_status :ok
        end
      end

      describe "#update" do
        it "updates the region" do
          @region.save
          put :update, id: @region.id, name: "New name"
          expect_json("region", { name: "New name", abbreviation: @region.abbreviation })
        end

        it "validates the json attribute types" do
          @region.save
          put :update, id: @region.id, name: "New name"
          expect_json_types("region", { id: :integer })
          expect_json_types("region", { name: :string })
          expect_json_types("region", { abbreviation: :string })
          expect_json_types("region", { time_zone: :string })
          expect_json_types("region", { archived: :boolean })
          expect_json_types("region", { test: :boolean })
        end

        it "returns a status of accepted (202)" do
          @region.save
          put :update, id: @region.id, name: "New name"
          expect_status :accepted
        end
      end

      describe "#delete" do
        it "returns empty json" do
          @region.save
          delete :destroy, id: @region.id
          expect_json_sizes 0
        end

        it "returns a status of accepted (202)" do
          @region.save
          delete :destroy, id: @region.id
          expect_status :accepted
        end

        it "deletes the specified instance" do
          @region.save
          expect { delete :destroy, id: @region.id }.to change(Region, :count).by(-1)
        end
      end
    end
  end
end
