require 'rails_helper'

RSpec.describe TestSuitesController, :type => :controller do

  let(:valid_attributes) {
    build(:test_suite).attributes.symbolize_keys
  }

  let(:invalid_attributes) {
    build(:test_suite, label: nil).attributes.symbolize_keys
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TestSuitesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET index' do
    it 'assigns all test_suites as @test_suites' do
      test_suite = TestSuite.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:test_suites)).to eq([test_suite])
    end
  end

  describe 'GET show' do
    it 'assigns the requested test_suite as @test_suite' do
      test_suite = TestSuite.create! valid_attributes
      get :show, {:id => test_suite.to_param}, valid_session
      expect(assigns(:test_suite)).to eq(test_suite)
    end
  end

  describe 'GET new' do
    it 'assigns a new test_suite as @test_suite' do
      get :new, {}, valid_session
      expect(assigns(:test_suite)).to be_a_new(TestSuite)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested test_suite as @test_suite' do
      test_suite = TestSuite.create! valid_attributes
      get :edit, {:id => test_suite.to_param}, valid_session
      expect(assigns(:test_suite)).to eq(test_suite)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new TestSuite' do
        expect {
          post :create, {:test_suite => valid_attributes}, valid_session
        }.to change(TestSuite, :count).by(1)
      end

      it 'assigns a newly created test_suite as @test_suite' do
        post :create, {:test_suite => valid_attributes}, valid_session
        expect(assigns(:test_suite)).to be_a(TestSuite)
        expect(assigns(:test_suite)).to be_persisted
      end

      it 'redirects to the created test_suite' do
        post :create, {:test_suite => valid_attributes}, valid_session
        expect(response).to redirect_to(TestSuite.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved test_suite as @test_suite' do
        post :create, {:test_suite => invalid_attributes}, valid_session
        expect(assigns(:test_suite)).to be_a_new(TestSuite)
      end

      it "re-renders the 'new' template" do
        post :create, {:test_suite => invalid_attributes}, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) {
        build(:test_suite, label: 'Test Suite 2').attributes.symbolize_keys
      }

      it 'updates the requested test_suite' do
        test_suite = TestSuite.create! valid_attributes
        put :update, {:id => test_suite.to_param, :test_suite => new_attributes}, valid_session
        test_suite.reload
        expect(test_suite.label).to eq 'Test Suite 2'
      end

      it 'assigns the requested test_suite as @test_suite' do
        test_suite = TestSuite.create! valid_attributes
        put :update, {:id => test_suite.to_param, :test_suite => valid_attributes}, valid_session
        expect(assigns(:test_suite)).to eq(test_suite)
      end

      it 'redirects to the test_suite' do
        test_suite = TestSuite.create! valid_attributes
        put :update, {:id => test_suite.to_param, :test_suite => valid_attributes}, valid_session
        expect(response).to redirect_to(test_suite)
      end
    end

    describe 'with invalid params' do
      it 'assigns the test_suite as @test_suite' do
        test_suite = TestSuite.create! valid_attributes
        put :update, {:id => test_suite.to_param, :test_suite => invalid_attributes}, valid_session
        expect(assigns(:test_suite)).to eq(test_suite)
      end

      it 're-renders the \'edit\' template' do
        test_suite = TestSuite.create! valid_attributes
        put :update, {:id => test_suite.to_param, :test_suite => invalid_attributes}, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested test_suite' do
      test_suite = create(:test_suite)
      expect {
        delete :destroy, {:id => test_suite.to_param}, valid_session
      }.to change(TestSuite, :count).by(-1)
    end

    it 'destroys the child web_tests for requested test_suite' do
      test_suite = create(:web_test).test_suite
      expected_change = -test_suite.web_test.count
      expect {
        delete :destroy, {:id => test_suite.to_param}, valid_session
      }.to change(WebTest, :count).by(expected_change)
    end

    it 'redirects to the test_suites list' do
      test_suite = TestSuite.create! valid_attributes
      delete :destroy, {:id => test_suite.to_param}, valid_session
      expect(response).to redirect_to(test_suites_url)
    end
  end

  describe 'POST execute' do
    it 'should commence the execution of each WebTest' do
      submit_test_stub
      test_suite = create(:web_test).test_suite
      post :execute, {id: test_suite.to_param}, valid_session

      test_suite.web_test.each  do |test|
        expect(test.running?).to be_truthy
      end
    end

    it 'redirects to the test_suites list' do
      submit_test_stub
      test_suite = create(:web_test).test_suite
      post :execute, {id: test_suite.to_param}, valid_session
      expect(response).to redirect_to(test_suite)
    end
  end

end
