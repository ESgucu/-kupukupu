require 'benchmark'

def run_script_and_measure_time
  # Start measuring time
  time = Benchmark.measure do

require 'open-uri'
require 'nokogiri'
require 'selenium-webdriver'
require 'json'

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--disable-gpu')
options.add_argument('--no-sandbox')

driver = Selenium::WebDriver.for :chrome, options: options

city = "izmir"
country = "turkey"
travel_date = "2024-08-02"
return_date = "2024-08-11"

url = "https://www.kiwi.com/en/search/tiles/#{city}-#{country}/anywhere/#{travel_date}/#{return_date}?sortAggregateBy=price"

driver.get(url)

wait = Selenium::WebDriver::Wait.new(timeout: 20)
max_retries = 3
retries = 0

begin
  begin
    accept_button = wait.until { driver.find_element(css: "button[data-test='CookiesPopup-Accept']") }
    accept_button.click
    wait.until { driver.find_element(css: '.bg-picture-card-overlay') }
  rescue Selenium::WebDriver::Error::StaleElementReferenceError => e
    retries += 1
    if retries <= max_retries
      puts "Retrying due to stale element reference: #{e.message}"
      retry
    else
      puts "Max retries reached: #{e.message}"
      driver.quit
      exit
    end
  end


  page_source = driver.page_source
  driver.quit


  # Save the page source to a file for inspection
  File.open("page_source.html", "w") { |file| file.write(page_source) }

  html_doc = Nokogiri::HTML(page_source)
  elements = html_doc.css('.group.relative.flex.h-full.w-full.flex-col.justify-end.overflow-hidden.rounded-large.p-sm.shadow-action.hover\\:shadow-action-active')
  # puts elements

  puts "Found #{elements.size} elements."

  destinations_data = []
  # destinations_prices = {} # Initialize an empty hash to store the destinations and prices

  if elements.empty?
    puts "No elements found with the class '.group.relative.flex.h-full.w-full.flex-col.justify-end.overflow-hidden.rounded-large.p-sm.shadow-action.hover\\:shadow-action-active'."
  else
    elements.each do |element|
      image_url = element.at_css('img')&.attr('srcset') if element.at_css('img')
      # Splitting text by 'loading' to separate individual destinations
      puts image_url
      text = element.text.split('loading')
      next_text = []
      text.each do |line|
        updated = I18n.transliterate(line).split('?')[1]
        currency = I18n.transliterate(line).split('?')[2]
        with_currency = "#{updated} #{currency}"
        next_text << with_currency
      end
      # puts next_text
      text = next_text.compact

      # Split the text into lines
      lines = text

      # Iterate over each line
      lines.each do |line|
        # Ensure the line is not an array
        line = line.join if line.is_a?(Array)
        # puts line
        next if line.nil? || line.strip.empty?
        # Match the city, country, and price using a regex
        if match_data = line.match(/(.+?), (.+?)Tickets from ([\d,]+)(.*)/)
          city_country = "#{match_data[1].strip}, #{match_data[2].strip}"
          price = match_data[3].gsub(',', '').to_i
          currency = match_data[4]
          # puts match_data
          destination_price = {
            'city_country' => city_country,
            'price' => price,
            'currency' => currency,
            'img' => image_url
          }
          # puts destination_price
          destinations_data << destination_price
        end
      end
    end
  end
  puts destinations_data
rescue Selenium::WebDriver::Error::NoSuchElementError, Selenium::WebDriver::Error::TimeoutError => e
  puts "Element not found or timeout: #{e.message}"
  driver.quit
  exit
end
end

# Output the time taken
puts "Code execution took #{time.real.round(2)} seconds."
end

# Call the method to run the script and measure time
run_script_and_measure_time
