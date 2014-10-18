require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '1m' do
  tests = WebTest.where(:status => 1)
  tests.each do |t|
    puts("Calling execute on WebTest #{t.id}")
    t.execute
  end
end