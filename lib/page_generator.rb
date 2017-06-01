# frozen_string_literal: true
module PageGenerator
  PAGE_ACCOUNTS = [
    'http://inkprofy.com'
  ].freeze

  def create_page(titles, descriptions)
    titles = titles.split("\r\n")
    descriptions = descriptions.split("\r\n")
    perform(titles, descriptions)
  end

  private

  def picture_link(title)
    year = Time.new.year
    month = Time.new.month.to_s.rjust(2, '0')
    dashed_title = title.tr(' ', '-')
    source = "{session[:page_acoount]}/wp-content/uploads/#{year}/#{month}/#{dashed_title}.jpg"
    link = "<img class='aligncenter size-full' src='#{source}' alt='#{title}' > \n"
    link
  end

  def perform(titles, descriptions)
    html_page = ''
    titles.length.times do |i|
      html_page += "<h3>##{i + 1}. #{titles[i]}</h3>"
      html_page += picture_link(titles[i])
      html_page += descriptions[i] + "\n" unless descriptions.empty?
    end
    html_page
  end
end
