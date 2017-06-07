# frozen_string_literal: true
module PicsParser
  AVALIBLE_SOURCES = %w(instagram lookbook pinterest).freeze

  def parse_urls(urls)
    dirty_links = urls.split("\r\n")
    dirty_links.map do |link|
      select_source(link)
    end
  end

  private

  def select_source(link)
    page = Nokogiri::HTML(open(link))
    return instagram_url(page) if link.index(AVALIBLE_SOURCES[0])
    return lookbook_url(page) if link.index(AVALIBLE_SOURCES[1])
    return pinterest_url(page) if link.index(AVALIBLE_SOURCES[2])
  end

  def instagram_url(page)
    page.at_css('[property="og:image"]').attributes['content'].value
  end

  def lookbook_url(page)
    page.at_css('[class="unselectable"]').attr('src')[2..-1]
  end

  def pinterest_url(page)
    page.at_css('img').attributes['src'].value
  end
end
