require_relative 'env'

# models:
#
# Message
# LicenseId
# MediaData (metadata for media)
# Song/VideoToken
# P2PCommerce (advertise price <op-ret-1> -> record buy action <op-ret-2>)
# SystemChainSnapshot (snapshots memory / disk hashes of all the programs etc..)
# ..

class App

  def self.start
    # get "block"

    data = { foo: "bar" } # your application state (from your user's side)

    foobar = Marshal.dump data

    op_r   = OpReturnApi.new "address"
    object = Marshal.load op_r.first.fetch(:data)

    object.new

    # OP_RETURN
    #
    # tx bitcoin -> models unmarshal
  end

  # net + block explorer host
  #
  # def self.get(url)
  #   url  = URI.parse url
  #   resp = Net::HTTP.get_response url
  #   Oj.load resp.body
  # end

end

App.start
