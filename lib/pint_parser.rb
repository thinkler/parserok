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

  URL = "https://api.pinterest.com/v1/me/"
  FOLLOWERS = 'followers/?access_token='
  FOLLOWING = 'following/users/?access_token='
  OPTIONS = '&fields=url&limit=100&'

  def parse_follow(account)
    @@token = ACCOUNTS_TOKENS[account.to_sym]
    get_data
  end

  private

  def get_data
    followers = get_followers
    following = get_following
    { followers: followers, following: following, bastards: following - followers }
  end

  def get_followers
    get_urls(FOLLOWERS)
  end

  def get_following
    get_urls(FOLLOWING)
  end

  def get_urls(type)
    result = []
    cursor = ""
    loop do
      response = make_request(type, cursor)
      cursor = response[:next]
      result += get_users_urls(response[:data])
      break unless cursor
    end
    return result
  end

  def make_request(type, cursor)
    response = Faraday.get(URL + type + @@token + OPTIONS + cursor)
    body = JSON.parse(response.body.gsub('=>', ':'))
    next_page = body["page"]["next"]
    data = body["data"]
    { data: data, next: next_page }
  end

  def get_users_urls(data)
    data.inject([]) { |arr, hash| arr << hash["url"]}
  end

end
