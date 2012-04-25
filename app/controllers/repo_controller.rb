class RepoController < ApplicationController
  
  # index
  # display all repos
  def index
    @repos = Repo.order("watchers DESC")
    
    @repos_count = @repos.length
    
    respond_to do |format|
      format.html #index.html.haml
    end
  end

  # show
  # display one repo
  # allow tags to be added
  # display alternatives / options user might want to know about
  def show
    @repo = Repo.find_by_owner_and_name(params[:owner], params[:name])
    
    # only show similarly tagged repos if the repo has been tagged
    if @repo.taggings != []
      @similar_repos = @repo.tagged_similar
    else
      @similar_repos = []
    end
    
    respond_to do |format|
      format.html #show.html.haml
    end
  end

  # add_repo
  # get request to '/add_repo?url=https://github.com/thomasklemm/repos'
  #   will add repo to this app
  # in use in bookmarklet
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

  # mercury_and_tags_update
  # allows updating a repo's tags
  #   through put request to '/repo/:owner/:name'
  #   params in body
  # allows updating a repo's wiki_text
  #   using the mercury visual editor
  #   through put request to '/repo/:owner/:name'
  #   params in body
  def mercury_and_tags_update
    # owner and name in route
    repo = Repo.find_by_owner_and_name(params[:owner], params[:name])
    
    # is it tags update or a mercury update request?
    if params["content"]
      # it's a mercury request
      wiki_text_new = JSON.parse(params["content"])["wiki_text_edit"]["value"]

      puts "New wiki_text for #{repo.ident}: '#{wiki_text_new.inspect}'"
      repo.wiki_text = wiki_text_new

      repo.save

      render text: "{}"
    else
      # it's a request updating tags (most likely)
      # each tag_context
      %w{languages frameworks tags}.each do |context|
        t1 = params[context]
        # split tags
        t1 = t1.split(",")
        tag_values = []
        # each tag
        t1.each do |value|
          # clean whitespace
          value = value.strip
          # do here
          # sanitize
          tag_values << value
        end
        # update repo using update_attribute because save somehow does not cause tags to be saved
        repo.update_attribute(context, tag_values)
      end
      # do: catch  errors for requests that are neither mercury nor tags
      respond_to do |format|
        format.html { redirect_to "/repo/#{repo.ident}", notice: "Tags saved." }
      end

      # do later: user experience improvement => ajax request for updating tags
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
