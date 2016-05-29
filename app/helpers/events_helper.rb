module EventsHelper
  def clean_whois(whois)
    whois.to_s.each_line.reject{|x| x.strip =~ /^([#%*]|$)/}.join.encode('UTF-8', {invalid: :replace, undef: :replace, replace: '.'})
  end
end
