class CodeFilesController < ApplicationController
  def index
    @repository = Repository.find(params[:repository_id])
    @code_files = @repository.code_files.ordered(params[:sort])
  end

  def show
    @repository = Repository.find(params[:repository_id])
    @code_file = @repository.code_files.find(params[:id])
  end
end
