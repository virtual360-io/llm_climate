class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.all
  end

  def show
    @repository = Repository.find(params[:id])
    @code_files = @repository.code_files
  end

  def new
    @repository = Repository.new
  end

  def create
    @repository = Repository.new(repository_params)
    if @repository.save
      redirect_to repositories_path
    else
      render :new
    end
  end

  def edit
    @repository = Repository.find(params[:id])
  end

  def update
    @repository = Repository.find(params[:id])
    if @repository.update(repository_params)
      redirect_to repositories_path
    else
      render :edit
    end
  end

  def destroy
    @repository = Repository.find(params[:id])
    @repository.destroy
    redirect_to repositories_path
  end

  private

    def repository_params
      params.require(:repository).permit(:url)
    end
end
