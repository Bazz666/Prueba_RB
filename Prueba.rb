require "uri"
require "net/http"
require "json"


#url = URI("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=TB1j1Qlk3cXb7jyBO085cD4LizEVOgeCKbSnbcTf")

def request(address, api_key="TB1j1Qlk3cXb7jyBO085cD4LizEVOgeCKbSnbcTf") 

    url = URI("#{address}&api_key=#{api_key}")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url)

    response = http.request(request)
    
    body = JSON.parse response.read_body  #llamamos al Json para ordenar nuestra base de datos




