class FakeJob < ApplicationJob
  queue_as :default

  def perform
    puts "I'm starting the fake job"
    sleep 3
    puts "I'm finishing the fake job"
  end
end
