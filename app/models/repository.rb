class Repository < ApplicationRecord
  has_many :code_files, dependent: :destroy

  def checkout
    Dir.mktmpdir do |dir|
      Git.clone(url, dir)
      git = Git.open(dir)

      self.code_files = fetch_files(git, dir)
    end

    self.save!
  end

  private

    def fetch_files(git, dir)
      file_paths = Dir.glob("#{dir}/**/*").select { valid_file(_1) }

      update_existing_files(git, dir, file_paths) | build_new_files(git, dir, file_paths)
    end

    def update_existing_files(git, dir, file_paths)
      self.code_files.where(path: file_paths.map { _1.gsub("#{dir}/", "") }).map do |code_file|
        file_path = "#{dir}/#{code_file.path}"

        code_file.attributes = CodeFile.code_file_attributes(git, dir, file_path)

        file_paths.delete(file_path)

        code_file
      end
    end

    def build_new_files(git, dir, file_paths)
      file_paths.map do |file_path|
        self.code_files.build(path: file_path.gsub("#{dir}/", ""), **CodeFile.code_file_attributes(git, dir, file_path))
      end
    end

    def valid_file(file_path)
      File.file?(file_path) && ENV["FILE_EXTENSIONS"].split(",").include?(File.extname(file_path)[1..-1]) && (ENV["FILE_EXCLUSION"].blank? || /#{ENV['FILE_EXCLUSION']}/ !~ file_path)
    end
end
