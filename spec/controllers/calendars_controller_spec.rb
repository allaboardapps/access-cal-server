require "rails_helper"

describe CalendarsController, type: :controller do
  let(:calendar) { FactoryGirl.create :calendar }

  describe "#index" do
    render_views

    it "receives a success status for the index page" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the correct view template" do
      get :index
      expect(response).to render_template(:application)
    end

    it "renders a list of objects" do
      calendar.save
      get :index
      expect(response.body).to match /#{calendar.name}/
    end
  end

  describe "#show" do
    render_views

    it "receives a success status for a single object page" do
      get :show, id: calendar.id
      expect(response).to have_http_status(:success)
    end

    it "renders the correct view template" do
      get :show, id: calendar.id
      expect(response).to render_template(:application)
    end

    it "renders a single object page" do
      get :show, id: calendar.id
      expect(response.body).to match /#{calendar.name}/
    end
  end

  describe "#new" do
    render_views

    it "receives a success status for the new object form" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the correct view template" do
      get :new
      expect(response).to render_template(:application)
    end

    it "renders the selected object form" do
      get :new
      expect(response.body).to match /Calendar Name/
    end
  end

  describe "#create" do
    it "creates a new object" do
      calendar_name = Faker::Hipster.sentence(8)
      post :create, name: calendar_name
      expect(Calendar.first.name).to eq calendar_name
    end

    it "does not create a new object" do
      calendar_name = Faker::Hipster.sentence(8)
      post :create, name: calendar_name
      expect(Calendar.count).to eq 1
    end

    it "redirects to the edit object page" do
      calendar_name = Faker::Hipster.sentence(8)
      post :create, name: calendar_name
      new_calendar = Calendar.first
      expect(response).to redirect_to edit_calendar_path(new_calendar)
    end
  end

  describe "#edit" do
    render_views

    it "receives a success status for the edit object form" do
      get :edit, id: calendar.id
      expect(response).to have_http_status(:success)
    end

    it "renders the correct view template" do
      get :edit, id: calendar.id
      expect(response).to render_template(:application)
    end

    it "renders the selected object form" do
      get :edit, id: calendar.id
      expect(response.body).to match /#{calendar.name}/
    end
  end

  describe "#update" do
    it "updates the object with an allowed attribute" do
      original_name = Faker::Hipster.sentence(8)
      calendar.update name: original_name
      new_name = Faker::Hipster.sentence(5)
      put :update, id: calendar.id, name: new_name
      expect(calendar.reload.name).to eq new_name
    end

    it "archives the selected object" do
      put :update, id: calendar.id, archived: true
      expect(calendar.reload.archived?).to be_truthy
    end

    it "unarchives the selected object" do
      put :update, id: calendar.id, archived: false
      expect(calendar.reload.archived?).to be_falsey
    end

    it "redirects to the object show page" do
      put :update, id: calendar.id, archived: true
      expect(response).to redirect_to calendar_path(calendar)
    end
  end

  describe "#delete" do
    it "destroys the selected object" do
      delete :destroy, id: calendar.id
      expect { calendar.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "redirects to the object index page" do
      delete :destroy, id: calendar.id
      expect(response).to redirect_to calendars_path
    end
  end
end
