class RepoController < ApplicationController
  
  # index
  # display all repos
  def index
    # Load all repos, sorted by watchers descending
    @repos = Repo.order("watchers DESC")
    
    # How many repos are listed?
    @repos_count = @repos.length

    respond_to do |format|
      format.html #index.html.haml
    end
  end

  # show
  # display one repo
  # allow tags to be added
  # display alternatives / options user might want to know about
  # display repos tagged similar if there are tags
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

    # read owner and name from url
    ident = url.gsub("https://github.com/", "").strip
    owner = ident.split("/")[0].strip
    name = ident.split("/")[1].strip

    # find_or_initialize repo (to ensure that there are no duplicates)
    repo = Repo.find_or_initialize_by_owner_and_name(owner, name)

    respond_to do |format|
      # Initialize Repo, including check whether or not it exists on github
      if repo.new_record?
        # repo is a new record, up to now unknown
        if repo.initialize_repo
          # repo is now in database
          format.html { redirect_to "/repo/#{repo.ident}/", notice: "Repo '#{repo.ident}' added. What might be good tags for it?." }
        else
          # repo did not exist on github
          format.html { redirect_to :root, notice: "Repo '#{repo.ident}' could not be found on github."}
        end
      else
        # Repo already in database
        # run an update
        if repo.initialize_repo
          format.html { redirect_to "/repo/#{repo.ident}/", notice: "Repo '#{repo.ident}' added. What might be good tags for it?" }
        else
          format.html { redirect_to :root, notice: "Repo '#{repo.ident}' could not be found on github."}
        end
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
      # new wiki text
      wiki_text_new = JSON.parse(params["content"])["wiki_text_edit"]["value"]

      # Sanitize unsafe HTML (like script tags)
      # .scrub!(:prune) removes unsafe / unknown tag and their children
      # .to_text preserves whitespace around block level elements
      wiki_text_new = Loofah.fragment(wiki_text_new).scrub!(:prune).to_s

      # save the changes
      repo.wiki_text = wiki_text_new
      repo.save

      # mercury waiting for "200" response -> sending empty json string
      return render text: "{}"

    else

      # it's a request updating tags (most likely)
      # each tag_context
      %w{languages frameworks tags}.each do |tag_context|
        t1 = params[tag_context]
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
        repo.update_attribute(tag_context, tag_values)
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
