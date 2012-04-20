class RenameHtmlUrltoGithubUrl < ActiveRecord::Migration
  def change
  	change_table :repos do |t|
  		t.rename(:html_url, :github_url)
  	end
  end
end
