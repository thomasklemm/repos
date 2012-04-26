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

  # Should the homepage button be displayed or not?
  # depending on if there is a homepage set other than the github_url
  def display_homepage?(homepage, github_url)
    # is homepage empty? -> hide
    if homepage.empty?
      return "display: none"
    # is homepage equal to github_url? -> hide
    elsif homepage == github_url
      return "display: none"
    else
      # else show
      return ""
    end
  end

  # Takes an array of tags
  # and returns it as string
  # ready for filtrify
  def tag_list(tag_array)
    return tag_array.join(", ")
  end

  # Distance of time in days to now (time)
  # Return an integer containing the number of days the time given is in the past
  # 0 marks today, 1 marks yesterday, ...
  def days_ago(time)
    distance = ((Time.now - time) / (24*60*60)).floor
  end


  def days_ago_in_words(time)
    distance = ((Time.now - time) / (24*60*60)).floor

    case distance
    when 0
      "today"
    when 1
      "yesterday"
    else
      "#{distance} days ago" 
    end
  end

end
