class ChangeColumnDefaultsForListJs < ActiveRecord::Migration
  def change
  	change_column_default(:repos, :owner, '')
  	change_column_default(:repos, :name, '')
  	change_column_default(:repos, :description, '')
  	change_column_default(:repos, :watchers, 0)
  	change_column_default(:repos, :forks, 0)
  	change_column_default(:repos, :github_url, '')
  	change_column_default(:repos, :homepage, '')
  	change_column_default(:repos, :wiki_text, '')
  end
end
