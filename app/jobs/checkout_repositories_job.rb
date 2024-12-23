class CheckoutRepositoriesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Repository.all.each do |repository|
      CheckoutRepositoryJob.perform_later(repository)
    end
  end
end
