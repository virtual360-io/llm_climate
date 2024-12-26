class CodeFile < ApplicationRecord
  scope :ordered, ->(sort) {
    case sort
    when "path", nil, ""
      order("path asc")
    else
      order("#{sort}_grade asc")
    end
  }

  belongs_to :repository
  after_commit :async_review, if: -> { saved_change_to_sync_at? }

  def review=(review)
    %w[overall refactoring performance security].each do |category|
      self.send("#{category}_grade=", review.dig(category, "grade"))
      self.send("#{category}_review=", review.dig(category, "review"))
    end
  end

  class << self
    def code_file_attributes(git, file_path)
      {
        content: File.read(file_path),
        sync_at: git.log(1).object(file_path).first.date
      }
    end
  end

  private

    def async_review
      CodeFileReviewJob.perform_later(self)
    end
end
