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
        format.html { redirect_to "/repo/#{repo.ident}/", notice: "Repo added." }
      else
        format.html { redirect_to :root, notice: "Repo not found on github."}
      end
    end
  end

  def mercury_update
    repo = Repo.find_by_owner_and_name(params[:owner], params[:name])
    wiki_text_new = JSON.parse(params["content"])["wiki_text_edit"]["value"]

    puts "New wiki_text for #{repo.ident}: '#{wiki_text_new.inspect}'"
    repo.wiki_text = wiki_text_new

    repo.save

    render text: "{}"
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
