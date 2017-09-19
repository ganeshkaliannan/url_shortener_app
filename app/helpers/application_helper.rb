module ApplicationHelper
	  # generate a url from a url string
  def s_url(url, owner: nil, custom_key: nil, expires_at: nil, fresh: false, url_options: {})
    short_url = Shortener::ShortenedUrl.generate(url,
                                                  owner:      owner,
                                                  custom_key: custom_key,
                                                  expires_at: expires_at,
                                                  fresh:      fresh
                                                )

    if short_url
      options = { controller: :"visitors", action: :show, id: short_url.unique_key, only_path: false }.merge(url_options)
      url_for(options)
    else
      url
    end
  end
end
