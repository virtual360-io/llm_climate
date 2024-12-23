class CheckoutRepositoryJob < ApplicationJob
  queue_as :default

  def perform(repository)
    repository.checkout
  end
end
