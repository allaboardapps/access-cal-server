require "rails_helper"

describe CalendarsController, type: :controller do  let(:event) { FactoryGirl.create :event }
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
      event.save
      get :index
      expect(response.body).to match /#{event.name}/
    end
  end

  describe "#show" do
    render_views

    it "receives a success status for a single object page" do
      get :show, id: event.id
      expect(response).to have_http_status(:success)
    end

    it "renders the correct view template" do
      get :show, id: event.id
      expect(response).to render_template(:application)
    end

    it "renders a single object page" do
      get :show, id: event.id
      expect(response.body).to match /#{event.name}/
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
      expect(response.body).to match /Event Name/
    end
  end

  describe "#create" do
    it "creates a new object" do
      event_name = Faker::Hipster.sentence(8)
      post :create, name: event_name
      expect(Event.first.name).to eq event_name
    end

    it "does not create a new object" do
      event_name = Faker::Hipster.sentence(8)
      post :create, name: event_name
      expect(Event.count).to eq 1
    end

    it "redirects to the edit object page" do
      event_name = Faker::Hipster.sentence(8)
      post :create, name: event_name
      new_event = Event.first
      expect(response).to redirect_to edit_event_path(new_event)
    end
  end

  describe "#edit" do
    render_views

    it "receives a success status for the edit object form" do
      get :edit, id: event.id
      expect(response).to have_http_status(:success)
    end

    it "renders the correct view template" do
      get :edit, id: event.id
      expect(response).to render_template(:application)
    end

    it "renders the selected object form" do
      get :edit, id: event.id
      expect(response.body).to match /#{event.name}/
    end
  end

  describe "#update" do
    it "updates the object with an allowed attribute" do
      original_name = Faker::Hipster.sentence(8)
      event.update name: original_name
      new_name = Faker::Hipster.sentence(5)
      put :update, id: event.id, name: new_name
      expect(event.reload.name).to eq new_name
    end

    it "archives the selected object" do
      put :update, id: event.id, archived: true
      expect(event.reload.archived?).to be_truthy
    end

    it "unarchives the selected object" do
      put :update, id: event.id, archived: false
      expect(event.reload.archived?).to be_falsey
    end

    it "redirects to the object show page" do
      put :update, id: event.id, archived: true
      expect(response).to redirect_to event_path(event)
    end
  end

  describe "#delete" do
    it "destroys the selected object" do
      delete :destroy, id: event.id
      expect { event.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "redirects to the object index page" do
      delete :destroy, id: event.id
      expect(response).to redirect_to events_path
    end
  end
end
