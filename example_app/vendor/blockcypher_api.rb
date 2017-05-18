# blockcypher address - get address data - uses BlockCypher::Api

require 'blockcypher'

class BCypherAddress

  attr_reader :address, :transactions
  alias :addr :address

  def initialize(address)
    @address = new_address addr: address

    @api = BlockCypher::Api.new
    def @api.tx(hash)
      @transactions       = super(hash)
    end
    def @api.address(addr)
      @address[:data]     = super addr
    end
    def @api.address_full(addr)
      @address[:data_tx]  = super addr
    end
  end

  def data
    txs = transactions
    txs
  end

  # TODO: add OP_RETURN parsing / OP_RETURN data - https://runkit.com/makevoid/ - https://runkit.com/makevoid/bcypher-op-return (prototype that calls the endpoint for now... TODO)

  def transactions
    addr = begin
      @api.address_full @address
    rescue BlockCypher::Api::Error => e
      raise e
      return
    end
    addr["txs"]
  end

  private

  def new_address(addr:)
    {
     address: addr,
     data:    nil
     data_tx: nil
   }
  end

end

# ---

require_relative 'vendor/blockcypher_address'
address = BCypherAddress.new "1C9CBnURHVbsLtpwby75jWnm36CQH6WKXJ"

require 'pp'
puts "Address (from blockypher)"
p address
puts

# address = BCypherAddress.new "1C9CBnURHVbsLtpwby75jWnm36CQH6WKXJ"
# puts address.data
# puts "done"
