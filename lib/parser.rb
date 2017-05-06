module InstaParser
  LINK_MATCHER = /(?<=<meta property=\"og:image\" content=\")(.*)(?=\" \/>)/
  URL_SHCEME = "https"
  AVALIBLE_SOURCES = /instagram|pinterest/



  def parse_urls(urls)
    dirty_links = urls.split("\n")
    dirty_links.map! { |dl| dl if AVALIBLE_SOURCES.match(dl) }
    dirty_links.map! { |link| link.chomp("\r") if link }
    dirty_links.map { |link| get_response_body(link) if link}
  end

  private

  def avalible?
    Proc.new do |link|
      permission = false
      AVALIBLE_LINK.each do |al|
        permission = link.include?(aa)
      end
      permission
    end
  end

  def get_response_body(link)
    url = URI.parse(link.to_s)
    req = Net::HTTP::Get.new(url.request_uri)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == URL_SHCEME)
    response = http.request(req)
    response.body.match(LINK_MATCHER)[0]
  end

end
