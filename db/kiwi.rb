require 'open-uri'
require 'nokogiri'
require 'selenium-webdriver'

# Set up Selenium with a headless browser
options = Selenium::WebDriver::Chrome::Options.new
# options.add_argument('--headless')
options.add_argument('--disable-gpu')
options.add_argument('--no-sandbox')

# Start a new Selenium session
driver = Selenium::WebDriver.for :chrome, options: options

# Parameters for the search
city = "izmir"
country = "turkey"
travel_date = "2024-08-02"
return_date = "2024-08-11"

# URL of the webpage you want to scrape
url = "https://www.kiwi.com/en/search/tiles/#{city}-#{country}/anywhere/#{travel_date}/#{return_date}?sortAggregateBy=price"



# Navigate to the page
driver.get(url)

# Wait until the element that indicates the page is fully loaded is present
wait = Selenium::WebDriver::Wait.new(timeout: 10) # seconds
# Find and click the accept button for cookies popup
begin
  accept_button = driver.find_element(css: "button[data-test='CookiesPopup-Accept']")
  accept_button.click
  puts "Clicked on the cookies accept button."
  begin
    # Check if a specific element is loaded
    puts "Waiting for page to load..."
    wait.until { driver.find_element(css: '.bg-picture-card-overlay') }
  rescue Selenium::WebDriver::Error::TimeoutError
    puts "Timeout: Content not fully loaded."
    driver.quit
    exit
  end
rescue Selenium::WebDriver::Error::NoSuchElementError
  puts "Cookies accept button not found."
end


# Continue with further actions on the page after accepting cookies
# Example: Print the current URL after accepting cookies
puts "Current URL: #{driver.current_url}"



puts "ok out"
# Get the page source after it has been fully loaded
page_source = driver.page_source

# Close the Selenium session
driver.quit

# Parse the page source with Nokogiri
html_doc = Nokogiri::HTML(page_source)

# Search for elements with the class `flex flex-wrap tb:-me-md`
elements = html_doc.css('.flex.flex-wrap.tb\\:-me-md')

# Check if elements are found and print them
if elements.empty?
  puts "No elements found with the class 'flex flex-wrap tb:-me-md'."
else
  elements.each do |element|
    puts "Element text: #{element.text}"
    text = element.text
    from = city.upcase
    # Extract city names and prices using a regular expression
    destinations = text.scan(/#{from} ([^,]+, [^T]+)Tickets from (\d+ €)/)
    puts destinations
    # puts "Element text: #{element.text.strip}"
    # Retrieve and print all 'href' attributes within the element
    element.css('a').each do |link|
      puts "Link href: #{link['href']}" if link['href']
    end
  end
end
