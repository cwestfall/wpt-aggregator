require 'rails_helper'

RSpec.describe WebTestsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # WebTest. As you add validations to WebTest, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    build(:web_test).attributes.symbolize_keys
  }

  let(:invalid_attributes) {
    build(:web_test, url: nil).attributes.symbolize_keys
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # WebTestsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET index' do
    it 'assigns all web_tests as @web_tests' do
      web_test = create(:web_test)

      get :index, {test_suite_id: web_test.test_suite.to_param}, valid_session
      expect(assigns(:web_tests)).to eq([web_test])
    end
  end

  describe 'GET show' do
    it 'assigns the requested web_test as @web_test' do
      web_test = create(:web_test)
      get :show, {id: web_test.to_param, test_suite_id: web_test.test_suite.to_param}, valid_session
      expect(assigns(:web_test)).to eq(web_test)
    end
  end

  describe 'GET new' do
    it 'assigns a new web_test as @web_test' do
      test_suite = create(:test_suite)
      get :new, {test_suite_id: test_suite.to_param}, valid_session
      expect(assigns(:web_test)).to be_a_new(WebTest)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested web_test as @web_test' do
      web_test = create(:web_test)
      get :edit, {id: web_test.to_param, test_suite_id: web_test.test_suite.to_param}, valid_session
      expect(assigns(:web_test)).to eq(web_test)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new WebTest' do
        expect {
          test_suite = create(:test_suite)
          post :create, {web_test: valid_attributes, test_suite_id: test_suite.to_param}, valid_session
        }.to change(WebTest, :count).by(1)
      end

      it 'assigns a newly created web_test as @web_test' do
        post :create, {web_test: valid_attributes, test_suite_id: '1'}
        expect(assigns(:web_test)).to be_a(WebTest)
        expect(assigns(:web_test)).to be_persisted
      end

      it 'redirects to the created web_test' do
        test_suite = create(:test_suite)
        post :create, {web_test: valid_attributes, test_suite_id: test_suite.to_param}, valid_session
        expect(response).to redirect_to(test_suite_web_test_path(test_suite, WebTest.last))
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved web_test as @web_test' do
        post :create, {web_test: invalid_attributes, test_suite_id: '1'}, valid_session
        expect(assigns(:web_test)).to be_a_new(WebTest)
      end

      it 're-renders the \'new\' template' do
        post :create, {web_test: invalid_attributes, test_suite_id: '1'}, valid_session
        expect(response).to render_template('new')
      end
    end

    describe 'with injected web parameters' do
      it 'does not modify \'status\' on object' do
        web_test = create(:web_test)
        web_test.status = :running
        post :create, {web_test: web_test.attributes.symbolize_keys, test_suite_id: web_test.test_suite.to_param}, valid_session
        expect(assigns(:web_test).status).to eq 'pending'
      end
    end

  end

  describe 'PUT update' do
    describe 'with valid params' do

      it 'updates the requested web_test' do
        web_test = create(:web_test)
        put :update, {id: web_test.to_param, test_suite_id: web_test.test_suite.to_param, web_test: valid_attributes}, valid_session
        web_test.reload
        expect(web_test.url).to eq 'http://www.google.com'
      end

      it 'assigns the requested web_test as @web_test' do
        web_test = create(:web_test)
        put :update, {id: web_test.to_param, test_suite_id: web_test.test_suite.to_param, web_test: valid_attributes}, valid_session
        expect(assigns(:web_test)).to eq(web_test)
      end

      it 'redirects to the web_test' do
        web_test = create(:web_test)
        put :update, {id: web_test.to_param, test_suite_id: web_test.test_suite.to_param, web_test: valid_attributes}, valid_session
        expect(response).to redirect_to(test_suite_web_test_path(web_test.test_suite, web_test))
      end
    end

    describe 'with invalid params' do
      it 'assigns the web_test as @web_test' do
        web_test = create(:web_test)
        put :update, {id: web_test.to_param, test_suite_id: web_test.test_suite.to_param, web_test: invalid_attributes}, valid_session
        expect(assigns(:web_test)).to eq(web_test)
      end

      it 're-renders the \'edit\' template' do
        web_test = create(:web_test)
        put :update, {id: web_test.to_param, test_suite_id: web_test.test_suite.to_param, web_test: invalid_attributes}, valid_session
        expect(response).to render_template('edit')
      end
    end

    describe 'with injected web parameters' do
      it 'does not modify \'status\' on object' do
        web_test = create(:web_test)
        web_test.status = :running
        put :update, {id: web_test.to_param, test_suite_id: web_test.test_suite.to_param, web_test: web_test.attributes.symbolize_keys}, valid_session
        expect(assigns(:web_test).status).to eq 'pending'
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested web_test' do
      web_test = create(:web_test)
      expect {
        delete :destroy, {id: web_test.to_param, test_suite_id: web_test.test_suite.to_param}, valid_session
      }.to change(WebTest, :count).by(-1)
    end

    it 'redirects to the web_tests list' do
      web_test = create(:web_test)
      delete :destroy, {id: web_test.to_param, test_suite_id: web_test.test_suite.to_param}, valid_session
      expect(response).to redirect_to(test_suite_web_tests_path(web_test.test_suite))
    end
  end

end
