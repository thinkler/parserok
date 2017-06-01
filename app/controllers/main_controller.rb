# frozen_string_literal: true
# Main controller
class MainController < ApplicationController
  include PicsParser
  include PintParser
  include PageGenerator

  def index; end

  def instagram_parser; end

  def titleizer; end

  def page_generator
    session[:page_accounts] = PAGE_ACCOUNTS  
  end

  # PAGE GENERATPOR

  def generate_page
    session[:page_account] = params[:page_account]
    @generated_page = create_page(params[:titles], params[:descriptions])
    render 'main/page_generator'
  end

  # TITLES

  def capitalize_titles
    @pretty_titles = perform_titles(params[:titles]).join("\n")
    render 'main/titleizer'
  end

  # PICS

  def parse_dirty_links
    @clear_links = parse_urls(params[:dirty_urls]).join("\n")
    render 'main/instagram_parser'
  end

  # PINTEREST

  def pinterest_followers
    session[:accounts] = ACCOUNTS
  end

  def parse_followers
    session[:account] = params[:account]
    pin_record = PinRecord.find_or_create_by(account: session[:account])
    @safe_bastards = pin_record.bastards_to_a
    @bastards = parse_bastards
    render 'main/pinterest_followers'
  end

  def update_bastards
    pin_record = PinRecord.find_by(account: session[:account])
    pin_record.bastards_to_string(params[:safe_bastards])
    pin_record.save
    redirect_to pinterest_path
  end

  def delete_bastards
    unfol_bastards(params[:bastards]) if params[:bastards]
    redirect_to pinterest_path
  end

  private

  def perform_titles(titles)
    titles_array = titles.split("\r\n")
    titles_array.map { |ta| titleize(ta) }
  end

  def titleize(str)
    str.capitalize!
    words_no_cap = %w(a an the at by for in of on to up and as but or nor)
    phrase = str.split(' ').map do |word|
      if words_no_cap.include?(word)
        word
      else
        word.capitalize
      end
    end.join(' ')
    phrase
  end
end
