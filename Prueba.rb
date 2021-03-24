require "uri"
require "net/http"
require "json"

url = URI("http://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=TB1j1Qlk3cXb7jyBO085cD4LizEVOgeCKbSnbcTf")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Get.new(url)

response = https.request(request)
puts response.read_body

body = JSON.parse response.read_body  #llamamos al Json para ordenar nuestra base de datos


