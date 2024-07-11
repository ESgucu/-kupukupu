class FlightsController < ApplicationController
  require 'open-uri'
  require 'nokogiri'
  require 'selenium-webdriver'

  def index
    city = params[:city] || "izmir"
    country = params[:country] || "turkey"
    travel_date = params[:travel_date] || "2024-08-02"
    return_date = params[:return_date] || "2024-08-11"

    url = "https://www.kiwi.com/en/search/tiles/#{city}-#{country}/anywhere/#{travel_date}/#{return_date}?sortAggregateBy=price"

    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--disable-gpu')
    options.add_argument('--no-sandbox')
    driver = Selenium::WebDriver.for :chrome, options: options

    driver.get(url)

    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    begin
      accept_button = driver.find_element(css: "button[data-test='CookiesPopup-Accept']")
      accept_button.click
      wait.until { driver.find_element(css: '.bg-picture-card-overlay') }
    rescue Selenium::WebDriver::Error::NoSuchElementError, Selenium::WebDriver::Error::TimeoutError
      driver.quit
      render json: { error: "Page did not load properly" }, status: :unprocessable_entity
      return
    end

    page_source = driver.page_source
    driver.quit

    html_doc = Nokogiri::HTML(page_source)
    elements = html_doc.css('.flex.flex-wrap.tb\\:-me-md')

    destinations_data = []

    if elements.empty?
      render json: { error: "No elements found" }, status: :not_found
    else
      elements.each do |element|
        text = element.text
        from = city.upcase
        destinations = text.scan(/#{from} ([^,]+, [^T]+)Tickets from (\d+) €/)

        destinations.each do |destination|
          city_country = destination[0].strip
          price = destination[1].to_i
          currency = "€"

          destinations_data << { destination: city_country, price: price, currency: currency }
        end
      end
      render json: destinations_data
    end
  end
end
