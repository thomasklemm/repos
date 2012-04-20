class ChangeColumnDefaultOfWikiText < ActiveRecord::Migration
  def change
  	change_column_default(:repos, :wiki_text, 'Placeholder Wiki-Text')
  end
end
