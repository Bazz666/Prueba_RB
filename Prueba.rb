require "uri"
require "net/https"
require "json"

#url = URI("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=TB1j1Qlk3cXb7jyBO085cD4LizEVOgeCKbSnbcTf")

def request(address, api_key="TB1j1Qlk3cXb7jyBO085cD4LizEVOgeCKbSnbcTf") 

    url = URI("#{address}&api_key=#{api_key}")
    https = Net::HTTP.new(url.host, url.port)

    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    response.read_body
    JSON.parse response.read_body  #llamamos al Json para ordenar nuestra base de datos
end

def build_web_page(request) # metodo que construlle Nuestra estructura HTML

    fotos = request.map{ |filter| filter['img_src'] } # filtramos solo la linea "img_src": "http://mars.....JPG"
    html = "<html>\n<head>\n</head>\n\t<body>\n\t\t<ul>" # Abrimos formato html, dejamos el head vacio y abrimos el body generando una lista 
    fotos.each do |img|
        html += "\n\t\t\t<li><img src='#{img}'></li>\n" #iteramos con each para insertar cada "img_src" como item dentro del <ul>
    end
    html += "\t\t</ul>\n\t</body>\n</html>" #finalmente cerramos la lista desordenada, el body y el html
    return html

end

photos = build_web_page(request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10')["photos"]) # manipulando el link podemos acotar la cantidad de fotografias cambiando "photos?sol=1000" cambiando el 1000 por el numero de imagenes deseadas

File.write('mars_Rovers_photos.html', photos.to_s)# le damos a la imagen el formato string para que nos las guarde como url


=begin
def photos_count(request)

    camera= request.map {|filter| filter[camera][name] }
    elementos= camera.group_by{ |name|name}
    print elementos

end

puts photos_count(request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=100'))
=end
