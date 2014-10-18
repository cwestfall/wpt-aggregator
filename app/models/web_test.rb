require 'webpagetest'

class WebTest < ActiveRecord::Base
  validates :url, format: { with: /\b((?:https?:\/\/|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/?)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s\`!()\[\]{};:\'\".,<>?«»“”‘’]))/i, message: 'must be a valid URL' }
  validates :test_suite, :presence => true

  enum status: [ :pending, :running, :complete ]

  belongs_to :test_suite
  belongs_to :average, class_name: 'Run'
  has_many :run

  def execute
    case self.status
      when 'pending'
        submit_test_request
      when 'running'
        retrieve_test_results
      when 'complete'
        # The test is done, there is nothing to do
      else
        puts('something went wrong')
        #TODO Raise some exception
    end
  end

  private
  def submit_test_request
    wpt = new_wpt
    response = wpt.run_test do |params|
      params.url = self.url
      params.location = self.location
      params.runs = self.requested_runs
    end
    self.wpt_id = response.test_id
    self.running!
    self.save
  end

  def retrieve_test_results
    wpt = new_wpt
    response = wpt.test_result(self.wpt_id)
    if response.get_status == :completed

      response.result.runs.each do |wpt_run|
        run = create_run(wpt_run[1])
        self.run << run
      end

      self.raw_result = response.raw.to_json
      self.average = create_run(response.result.average)

      self.complete!
      self.save
    end

  end

  private

  def new_wpt
    Webpagetest.new(k: '14ba2b6a7fa34d9a93709f4c4673d56d')
  end

  def create_run(wpt_run)
    Run.new do |r|
      r.first_view  = create_result(wpt_run.firstView)
      r.repeat_view = create_result(wpt_run.repeatView)
    end
  end

  def create_result(wpt_result)
    Result.new do |r|
      r.load_time         = wpt_result.loadTime
      r.ttfb              = wpt_result.TTFB
      r.bytes_out         = wpt_result.bytesOut
      r.bytes_out_doc     = wpt_result.bytesOutDoc
      r.bytes_in          = wpt_result.bytesIn
      r.bytes_in_doc      = wpt_result.bytesInDoc
      r.requests          = wpt_result.requests
      r.requests_doc      = wpt_result.requestsDoc
      r.render            = wpt_result.render
      r.fully_loaded      = wpt_result.fullyLoaded
      r.cached            = wpt_result.cached
      r.web               = wpt_result.web
      r.doc_time          = wpt_result.docTime
      r.dom_time          = wpt_result.domTime
      r.score_cache       = wpt_result.score_cache
      r.score_cdn         = wpt_result.score_cdn
      r.score_gzip        = wpt_result.score_gzip
      r.score_cookies     = wpt_result.score_cookies
      r.score_keep_alive  = wpt_result.score_keep_alive
      r.score_minify      = wpt_result.score_minify
      r.score_combine     = wpt_result.score_combine
      r.score_compress    = wpt_result.score_compress
      r.score_etags       = wpt_result.score_etags
      r.dom_elements      = wpt_result.domElements
      r.run_date          = wpt_result.date
    end
  end
end
