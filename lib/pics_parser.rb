module PicsParser
  EXPRESSIONS = {
    instagram: /(?<=<meta property=\"og:image\" content=\")(.*)(?=\" \/>)/
    # pinterest: /(?<=<img src=\")(.*)(?=\" class=\"pinImage\" \/>)/ // TODO
    # tumblr: some.slice(some.index("http://68.media.tumblr.com")..(some.index("\" ")-1)) // TODO
  }
  URL_SHCEME = "https"
  AVALIBLE_SOURCES = ["instagram"]

  def parse_urls(urls)
    dirty_links = urls.split("\r\n")
    dirty_links.map do |link|
      matcher = select_matcher(link)
      matcher ? get_response_body(matcher, link): "0"
    end
  end

  private

  def select_matcher(link)
    return :instagram if link.index(AVALIBLE_SOURCES[0])
  end

  def get_response_body(matcher, link)
    url = URI.parse(link.to_s)
    req = Net::HTTP::Get.new(url.request_uri)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == URL_SHCEME)
    response = http.request(req)
    response.body.match(EXPRESSIONS[matcher])[0]
  end

end