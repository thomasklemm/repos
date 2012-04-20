class RepoController < ApplicationController
  def index
    @repos = Repo.order("watchers DESC")

    respond_to do |format|
      format.html #index.html.haml
    end
  end

  def show
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
