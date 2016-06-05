module EventsHelper
  def clean_whois(whois)
    whois.to_s.each_line.reject{|x| x.strip =~ /^([#%*]|$)/}.join.encode('UTF-8', {invalid: :replace, undef: :replace, replace: '.'})
  end

  def events_by_ip(ip)
    link_to "#{ip}", events_path(ip: ip)
  end
end
