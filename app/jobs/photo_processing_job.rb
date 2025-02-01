class PhotoProcessingJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    user.photo.variant(resize: '100x100').processed
  end
end
