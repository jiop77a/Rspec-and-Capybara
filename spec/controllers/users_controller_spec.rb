require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders the new template" do
      get :new, {}
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the user's email and password" do
        post :create, {user_name: 'joe'}
        expect(flash[:errors]).to_not be_nil
        expect(response).to render_template("new")
      end
      it "validates that the password is at least 6 characters long" do
        post :create, {user_name: 'joe', password: 'abcd'}
        expect(flash[:errors]).to_not be_nil
        expect(response).to render_template("new")
      end
    end
    context "with valid params" do
      it "redirects user to the current user\'s showpage" do
        post :create, { user_name: 'joe', password: 'abcdef' }
        it { should redirect_to(user_url(User.last)) }
        it { should redirect_to(action: :show) }
      end
    end
  end

  describe "GET #show" do
    it "renders the show template" do
      post :create, { user_name: 'alex', password: 'password' }
      get :show, id: User.last.id

      it { should render_template("show") }
    end
  end

  describe "GET #index" do
    it "renders the index template" do
      get :index

      it { should render_template("index") }
    end
  end
end
