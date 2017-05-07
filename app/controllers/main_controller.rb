class MainController < ApplicationController
  include PicsParser
  include PintParser

  def index
    @data = parse_follow("wild")
  end

  def instagram_parser; end

  def pinterest_followers; end

  def parse_dirty_links
    @clear_links = parse_urls(params[:dirty_urls]).join("\n")
    render 'main/instagram_parser'
  end

  def parse_followers
    @follow_data = parse_follow(params[:account])
    byebug
    render 'main/pinterest_followers'
  end

end
