# ipinfo.io

```ruby
require 'json'
require 'open-uri'

JSON.parse(open('http://ipinfo.io/94.23.13.61/geo').read)
```

# threatcrowd

info: ''https://github.com/threatcrowd/ApiV2''

```ruby
require 'json'
require 'open-uri'

uri = 'https://www.threatcrowd.org/searchApi/v2/ip/report/?ip=94.23.13.61'
uri = 'https://www.threatcrowd.org/searchApi/v2/domain/report/?domain=superoptiresume.net'
JSON.parse(open(uri).read)
```

