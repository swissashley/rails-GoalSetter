require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  let(:user) { User.create!(username: 'jack_bruce', password: 'abcdef') }


  describe 'GET #new' do

    context 'user is not logged in' do
      it 'redirects to sign in page' do
        get :new, goal: {}
        expect(response).to redirect_to(new_session_url)
      end
    end

    context 'user is logged in' do

      before do
        allow(controller).to receive(:current_user) { user }
      end

      it 'reders the new template' do
          get :new
          expect(response).to render_template("new")
      end
    end

  end

  describe 'POST #create' do

    context 'user is not logged in' do
      it 'redirects to sign in page' do
        post :create, goal: {}
        expect(response).to redirect_to(new_session_url)
      end
    end

    context 'user is logged in' do

      before do
        allow(controller).to receive(:current_user) { user }
      end

      it 'shows index page if valid params' do
          post :create, goal: {user_id: 1,
                           title: "goal",
                           description: "not complete",
                           completion_date: Date.tomorrow,
                           is_private: false }
          expect(response).to redirect_to(goal_url(Goal.last))
      end

      it 'renders new page if invalid params' do
        post :create, goal: {user_id: 1,
                         completion_date: Date.tomorrow,
                         is_private: false}

        expect(response).to render_template("new")
      end
    end
  end

  describe 'GET #show' do
    create_user_with_goal

    context 'user is not logged in' do
      before do
        allow(controller).to receive(:current_user) { nil }
      end
      it 'redirects to sign in page' do
        get :show, id: user_goal.id

        expect(response).to redirect_to(new_session_url)
      end
    end

    context 'when logged in' do
      before do
        allow(controller).to receive(:current_user) { user }
      end

      it 'renders show template' do
        get :show, id: user_goal.id

        expect(response).to render_template("show")
      end
    end

  end

  describe 'GET #edit' do
    create_user_with_goal

    context 'user is not logged in' do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it 'redirects to sign in page' do
        get :edit, id: user_goal.id

        expect(response).to redirect_to(new_session_url)
      end
    end

    context 'user is logged in' do
      before do
        allow(controller).to receive(:current_user) { user }
      end
      it 'renders the edit page' do
        get :edit, id: user_goal.id
        expect(response).to render_template("edit")
      end
    end

  end

  describe 'PATCH #update' do
    create_user_with_goal

    context 'user is not logged in' do
      before do
        allow(controller).to receive(:current_user) { nil }
      end
      it 'redirects to sign in page' do
        patch :update, id: user_goal.id
        expect(response).to redirect_to(new_session_url)
      end
    end

    context 'user is logged in' do

      before do
        allow(controller).to receive(:current_user) { user }
      end

      it 'shows index page if valid params' do
          patch :update, id: user_goal.id, goal: { title: "new title" }

          updated_goal = Goal.find(user_goal.id)
          expect(updated_goal.title).to eq("new title")
      end

    end
  end

  describe 'DELETE #destroy' do
    create_user_with_goal

    context 'user is not logged in' do
      before do
        allow(controller).to receive(:current_user) { nil }
      end
      it 'redirects to sign in page' do
        delete :destroy, id: user_goal.id
        expect(response).to redirect_to(new_session_url)
      end
    end

    context 'user is logged in' do

      before do
        allow(controller).to receive(:current_user) { user }
      end

      it 'remove goal from db' do
          delete :destroy, id: user_goal.id

          expect(response).to redirect_to(goals_url)
          expect(Goal.exists?(user_goal.id)).to be_falsey
      end

    end
  end


end
