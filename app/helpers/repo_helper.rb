module RepoHelper

  def homepage_with_fallback_github_url(homepage, github_url)
    homepage_url = ""
    unless homepage.empty? or homepage.nil?
      homepage_url = homepage
    else
      homepage_url = github_url
    end
    return homepage_url
  end

  # Should the homepage button be displayed or not?
  # depending on if there is a homepage set other than the github_url
  def display_homepage?(homepage, github_url)
    # is homepage empty?
    if homepage.empty? or homepage.nil?
      return "display: none"
    elsif homepage == github_url
      return "display: none"
    else
      return "display: none"
    end
  end

  # Takes an array of tags
  # and returns it as string
  # ready for filtrify
  def tag_list(tag_array)
    return tag_array.join(", ")
  end

end
