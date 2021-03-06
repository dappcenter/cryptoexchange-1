module Cryptoexchange::Exchanges
  module SouthXchange
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::SouthXchange::Market::API_URL}/book/#{market_pair.base}/#{market_pair.target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = SouthXchange::Market::NAME
          order_book.asks      = adapt_orders output['SellOrders']
          order_book.bids      = adapt_orders output['BuyOrders']
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order|
            Cryptoexchange::Models::Order.new(
              price:     order['Price'],
              amount:    order['Amount'],
              timestamp: nil
            )
          end
        end
      end
    end
  end
end
