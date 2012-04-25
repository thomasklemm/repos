class Tag < ActiveRecord::Base
  attr_accessible :context, :name, :repo_count
end
