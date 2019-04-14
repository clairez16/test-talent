require 'json'
require 'open-uri'

class ConvertAmount
  ACCESS_KEY = 'dd515011c7c03f7d9436ec8d1a95d5b7'.freeze # irait dans un fichier .env

  def initialize(amount, origin_currency, destination_currency, date)
    @amount = amount
    @origin_currency = origin_currency
    @destination_currency = destination_currency
    @date = date
  end

  def convert
    url = 'http://data.fixer.io/api/' + @date + '?access_key=' + ACCESS_KEY + '&symbols=' + @origin_currency + ',' + @destination_currency + '&format=1'
    historical_rate_serialized = open(url).read
    historical_rate = JSON.parse(historical_rate_serialized, symbolize_names: true)
    return 'wrong request' unless historical_rate[:success]

    (@amount / historical_rate[:rates][@origin_currency.to_sym]).round(2)
  end
end
