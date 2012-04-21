class Repo < ActiveRecord::Base
  attr_accessible :description, :forks, :homepage, :github_url, :last_updated, :name, :owner, :watchers

  validates :owner, :name, presence: true

  before_save do |repo|

  end

  def ident
    return "#{self.owner}/#{self.name}"
  end

  def update_repo
    puts "starting to update_repo: #{self.owner}/#{self.name}"
    github = JSON.parse(Curl::Easy.perform("https://api.github.com/repos/" + self.owner + "/" + self.name).body_str)
    
    if github["message"]
      # Something has gone wrong
      return false
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


  def initialize_repo
    puts "initialize_repo: #{self.owner}/#{self.name} finished successfully."
    self.update_repo 
  end

  def self.update_repos
  	# Find repos in batch sizes of 1000
  	Repo.find_each do |repo|
  		repo.update_repo
  	end

    puts "Job 'Repo.update_repos' finished successfully."

  end


end
