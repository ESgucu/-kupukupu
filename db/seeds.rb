text = "loadingloadingloadingloadingloadingloadingİzmir Barcelona, SpainTickets from 280 €loadingİzmir Tirana, AlbaniaTickets from 258 €loadingİzmir Amsterdam, NetherlandsTickets from 374 €Map is not supported. Please update your browser.loadingloadingloadingloadingloadingloadingloadingloadingloadingloadingloadingİzmir London, United KingdomTickets from 248 €loadingİzmir Frankfurt, GermanyTickets from 349 €loadingİzmir Vienna, AustriaTickets from 225 €loadingİzmir Paris, FranceTickets from 367 €loadingİzmir Munich, GermanyTickets from 315 €loadingİzmir Athens, GreeceTickets from 351 €Explore trending destinations on the mapExplore maploadingİzmir Zürich, SwitzerlandTickets from 354 €loadingİzmir Tbilisi, GeorgiaTickets from 193 €loadingİzmir Prague, CzechiaTickets from 319 €loadingİzmir Antalya, TurkeyTickets from 125 €loadingİzmir Düsseldorf, GermanyTickets from 263 €loadingİzmir Brussels, BelgiumTickets from 261 €loadingİzmir Hamburg, GermanyTickets from 336 €loadingİzmir Cologne, GermanyTickets from 269 €loadingİzmir Skopje, Republic of North MacedoniaTickets from 229 €loadingİzmir Trabzon, TurkeyTickets from 191 €loadingİzmir Belgrade, SerbiaTickets from 281 €loadingİzmir Stuttgart, GermanyTickets from 286 €loadingİzmir Istanbul, TurkeyTickets from 135 €loadingİzmir Baku, AzerbaijanTickets from 286 €loadingİzmir Bucharest, RomaniaTickets from 77 €loadingİzmir Ankara, TurkeyTickets from 141 €loadingİzmir Berlin, GermanyTickets from 299 €loadingİzmir Hanover, GermanyTickets from 320 €loadingİzmir Kayseri, TurkeyTickets from 154 €loadingİzmir Northern Cyprus, Unknown RegionTickets from 172 €loadingİzmir Adana, TurkeyTickets from 153 €"
from = "İzmir"
# Extract city names and prices using a regular expression
destinations = text.scan(/#{from} ([^,]+, [^T]+)Tickets from (\d+ €)/)
puts destinations

# Create an HTML string with Bootstrap cards
html_content = <<-HTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <title>Travel Destinations</title>
</head>
<body>
  <div class="container mt-5">
    <div class="row">
HTML

destinations.each do |destination|
  city_country, price = destination
  html_content += <<-HTML
      <div class="col-md-4">
        <div class="card mb-4 shadow-sm">
          <div class="card-body">
            <h5 class="card-title">#{city_country}</h5>
            <p class="card-text">Price: #{price}</p>
          </div>
        </div>
      </div>
  HTML
end

html_content += <<-HTML
    </div>
  </div>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
HTML

# Write the HTML content to a file
File.open("destinations.html", "w") do |file|
  file.write(html_content)
end

puts "HTML file has been created successfully."
