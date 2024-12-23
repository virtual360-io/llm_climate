class Repository < ApplicationRecord
  has_many :code_files, dependent: :destroy
end
