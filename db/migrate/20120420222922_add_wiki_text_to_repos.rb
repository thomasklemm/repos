class AddWikiTextToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :wiki_text, :text
  end
end
