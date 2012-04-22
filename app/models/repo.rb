class Repo < ActiveRecord::Base
  attr_accessible :owner, :name, :description, :github_url, :homepage, :forks, :watchers, :last_updated

  # contexts / scopes that are taggable
  attr_taggable :languages, :frameworks, :solutions

  validates :owner, :name, presence: true

  # repo.ident -> "thomasklemm/repos"
  # => returns a github ident string ('not what it's officially called, is it?')
  def ident
    return "#{self.owner}/#{self.name}"
  end

  # repo.update_repo
  # => fetches current repo data from github
  #    and updates fields that have changed
  # 
  # => Data: name owner description watchers forks homepage github_url last_updated
  #
  # used in
  # => initialize_repo
  # => Repo.update_repos
  def update_repo
    puts "starting to update_repo: '#{self.ident}'"
    github = JSON.parse(Curl::Easy.perform("https://api.github.com/repos/" + self.ident).body_str)
    
    if github["message"]
      # Something has gone wrong
      # probably: repo does not exist
      # => 1) incorrect information provided when adding a repo
      # => 2) previously existing repo has had some changes (e.g. name, ownership)
      return false
      # do: better error handling here
      # what happens if a repo has been renamed / ownership transferred / deleted
      # => set flag 'needs_an_eye' to true
      # => then jump to the next repo
      # => might be done using 'markable' gem
    else
      %w{name description watchers forks homepage}.each do |field|
        self[field] = github[field]
      end
      self["github_url"] = github["html_url"]
      self["owner"] = github["owner"]["login"]
      self["last_updated"] = github["updated_at"]
      self.save
    end
  end

  # repo.initialize_repo
  # => initializes a new repo
  # what should be given: repo.owner and repo.name
  def initialize_repo
    puts "starting to initialize repo: '#{self.ident}' finished successfully."
    self.update_repo
  end

  # Repo.update_repos
  # => rails runner "Repos.update_repos"
  # 
  # Cron job that will update the complete repository dataset
  # with current github data
  def self.update_repos
  	# Find repos in batch sizes of 1000
  	Repo.find_each do |repo|
  		repo.update_repo
  	end

    puts "Job 'Repo.update_repos' finished successfully."
  end


end
