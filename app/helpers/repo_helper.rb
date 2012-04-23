module RepoHelper

  def homepage_with_fallback_github_url(homepage, github_url)
    homepage_url = ""
    unless homepage.empty?
      homepage_url = homepage
    else
      homepage_url = github_url
    end
    return homepage_url
  end

  def display_homepage?(homepage)
    unless homepage.empty?
      return ""
    else
      return "display: none"
    end
  end

end
