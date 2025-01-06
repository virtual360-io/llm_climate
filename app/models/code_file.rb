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
    def code_file_attributes(git, dir, file_path)
      log = git.log(1).object(file_path).first

      {
        content: File.read(file_path),
        sync_at: log.date,
        url: get_remote_file_url(git, file_path.gsub(dir, ""), log.sha)
      }
    end

    private

      def get_remote_file_url(git, file_path, commit_hash)
        remote_url = git.remote.url

        remote_url = clean_remote_url(remote_url)

        if remote_url.include?("github.com")
          github_remote_url(remote_url, commit_hash, file_path)
        elsif remote_url.include?("gitlab.com")
          gitlab_remote_url(remote_url, commit_hash, file_path)
        else
          nil
        end
      end

      def clean_remote_url(remote_url)
        return remote_url unless remote_url.start_with?("git@")

        remote_url
          .sub(":", "/")
          .sub("git@", "https://")
          .sub(/.git$/, "")
      end

      def github_remote_url(remote_url, commit_hash, file_path)
        "#{remote_url}/blob/#{commit_hash}/#{file_path}"
      end

      def gitlab_remote_url(remote_url, commit_hash, file_path)
        "#{remote_url}/-/blob/#{commit_hash}/#{file_path}"
      end
  end

  private

    def async_review
      CodeFileReviewJob.perform_later(self)
    end
end
