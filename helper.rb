module Helper
  def wget_installed?
    if %x{which wget}
      return true
    else
      return false
    end
  end
  
  def valid_url?(url_s)
    if url_s =~ /\A#{URI::regexp(['http', 'https'])}\z/
      return true
    else
      return false
    end
  end
end
