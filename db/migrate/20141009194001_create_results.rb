class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.text :url
      t.integer :load_time
      t.integer :ttfb
      t.integer :bytes_out
      t.integer :bytes_out_doc
      t.integer :bytes_in
      t.integer :bytes_in_doc
      t.integer :requests
      t.integer :requests_doc
      t.integer :result
      t.integer :render
      t.integer :fully_loaded
      t.integer :cached
      t.integer :web
      t.integer :doc_time
      t.integer :dom_time
      t.integer :score_cache
      t.integer :score_cdn
      t.integer :score_gzip
      t.integer :score_cookies
      t.integer :score_keep_alive
      t.integer :score_minify
      t.integer :score_combine
      t.integer :score_compress
      t.integer :score_etags
      t.datetime :run_date

      t.timestamps
    end
  end
end
