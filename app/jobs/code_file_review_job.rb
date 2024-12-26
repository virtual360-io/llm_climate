class CodeFileReviewJob < ApplicationJob
  queue_as :default

  def perform(code_file)
    code_file.review = default_reviewer.new(code_file.content).review
    code_file.save!(validate: false)
  end

  def default_reviewer
    BedrockReviewer
  end
end
