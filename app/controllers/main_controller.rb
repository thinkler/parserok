require 'parser'
include InstaParser

class MainController < ApplicationController

  def index; end

  def instagram_parser ; end

  def pinterest_followers; end

  def parse_dirty_links
    @clear_links = parse_urls(params[:dirty_urls])
    render 'main/instagram_parser'
  end

end
