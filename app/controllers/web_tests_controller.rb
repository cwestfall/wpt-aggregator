class WebTestsController < ApplicationController
  before_action :set_web_test, only: [:show, :edit, :update, :destroy]
  before_action :set_test_suite

  # GET /web_tests
  # GET /web_tests.json
  def index
    @web_tests = @test_suite.web_test.all
  end

  # GET /web_tests/1
  # GET /web_tests/1.json
  def show
  end

  # GET /web_tests/new
  def new
    @web_test = @test_suite.web_test.new
  end

  # GET /web_tests/1/edit
  def edit
  end

  # POST /web_tests
  # POST /web_tests.json
  def create
    @web_test = @test_suite.web_test.new(web_test_params)

    respond_to do |format|
      if @web_test.save
        format.html { redirect_to [@test_suite, @web_test], notice: 'Web test was successfully created.' }
        format.json { render :show, status: :created, location: @web_test }
      else
        format.html { render :new }
        format.json { render json: @web_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /web_tests/1
  # PATCH/PUT /web_tests/1.json
  def update
    respond_to do |format|
      if @web_test.update(web_test_params)
        format.html { redirect_to [@test_suite, @web_test], notice: 'Web test was successfully updated.' }
        format.json { render :show, status: :ok, location: @web_test }
      else
        format.html { render :edit }
        format.json { render json: @web_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /web_tests/1
  # DELETE /web_tests/1.json
  def destroy
    @web_test.destroy
    respond_to do |format|
      format.html { redirect_to test_suite_web_tests_path(@test_suite), notice: 'Web test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_web_test
      @web_test = WebTest.find(params[:id])
    end

    def set_test_suite
      @test_suite = TestSuite.find(params[:test_suite_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def web_test_params
      params.require(:web_test).permit(:url, :label, :requested_runs, :location, :additional_parameters)
    end
end
