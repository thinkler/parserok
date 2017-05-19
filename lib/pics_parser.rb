module PicsParser
  EXPRESSIONS = {
    instagram: %r{(?<=<meta property=\"og:image\" content=\")(.*)(?=\" \/>)},
    lookbook: %r{(?<=itemprop=\"contentURL\" src=\"\/\/)(.*)(?=\" srcset)}
  }.freeze
  URL_SHCEME = 'https'.freeze
  AVALIBLE_SOURCES = %w(instagram lookbook).freeze

  def parse_urls(urls)
    dirty_links = urls.split("\r\n")
    dirty_links.map do |link|
      matcher = select_matcher(link)
      matcher ? get_response_body(matcher, link) : '0'
    end
  end

  private

  def select_matcher(link)
    return :instagram if link.index(AVALIBLE_SOURCES[0])
    return :lookbook if link.index(AVALIBLE_SOURCES[1])
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
