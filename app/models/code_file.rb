class CodeFile < ApplicationRecord
  belongs_to :repository
  after_commit :async_review, if: -> { saved_change_to_sync_at? }

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
