require 'fakeweb'

module FakeWebHelper

  FakeWeb.register_uri(
    :get, "https://www.threatcrowd.org/searchApi/v2/ip/report/?ip=1.2.3.4", 
    body: '{"response_code":"0"}'
  )


end
