class RepoController < ApplicationController
  def index
    @repos = Repo.order("watchers DESC")

    respond_to do |format|
      format.html #index.html.haml
    end
  end

  def show
    @repo = Repo.find_by_owner_and_name(params[:owner], params[:name])

    respond_to do |format|
      format.html #show.html.haml
    end
  end

  def add_repo
    url = params[:url]

    ident = url.gsub("https://github.com/", "").strip
    owner = ident.split("/")[0]
    name = ident.split("/")[1]

    repo = Repo.find_or_initialize_by_owner_and_name(owner, name)

    respond_to do |format|
      if repo.initialize_repo
        format.html { redirect_to "/repo/#{repo.owner}/#{repo.name}/", notice: "Repo successfully added." }
      else
        format.html { redirect_to :root, notice: "Repo not found on github."}
      end
    end
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
