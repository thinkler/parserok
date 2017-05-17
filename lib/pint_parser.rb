module PintParser
  ACCOUNTS = {
    "TheWildTattoo": "wild",
    "SweetyTextMessages": "sweet",
    "TheHairStyleDaily": "hair"
  }

  ACCOUNTS_TOKENS = {
    "wild": "ASKIatDc2KHFm-8D_6ZYTMv68a85FLv7CxrMVuBD9uZkCYArLAAAAAA",
    "sweet": "Af1TaYudagla5TYwigWONK1IFX7QFLv5lps5Qf5D-idtVqAzHAAAAAA",
    "hair": "Ae7GWbSWQBPIFGoUljDIAqPRYRKZFLv7psXrKX1D-ikzwyAsrAAAAAA"
  }

  # https://api.pinterest.com/v1/me/following/users/some/?access_token=

  URL = "https://api.pinterest.com/v1/me/"
  TOKEN = '/?access_token='
  FOLLOWERS = 'followers' + TOKEN
  FOLLOWING = 'following/users' + TOKEN
  UNFOLLOW = 'following/users/'
  OPTIONS = '&fields=url&limit=100&'

  def parse_bastards
    following - followers
  end

  def unfol_bastards(bastards)
    del_request(bastards)
  end

  private

  def followers
    get_urls(FOLLOWERS)
  end

  def following
    get_urls(FOLLOWING)
  end

  def get_urls(type)
    result = []
    cursor = ""
    loop do
      response = get_request(type, cursor)
      cursor = response[:next]
      result += get_users_urls(response[:data])
      break unless cursor
    end
    return result
  end

  def get_request(type, cursor)
    response = Faraday.get(URL + type + ACCOUNTS_TOKENS[session[:account].to_sym] + OPTIONS + cursor)
    body = JSON.parse(response.body.gsub('=>', ':'))
    next_page = body["page"]["next"]
    data = body["data"]
    { data: data, next: next_page }
  end

  def del_request(array)
    array.each do |a|
      Faraday.delete(URL + UNFOLLOW + get_username(a) + TOKEN + ACCOUNTS_TOKENS[session[:account].to_sym])
    end
  end

  def get_users_urls(data)
    data.inject([]) { |arr, hash| arr << hash["url"]}
  end

  def get_username(url)
    url.split('/')[-1]
  end

end
