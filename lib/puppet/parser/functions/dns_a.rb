module Puppet::Parser::Functions
  newfunction(:dns_a, :type => :rvalue, :arity => 1, :doc => <<-EOS
    Retrieves DNS A records and returns it as an array. Each record in the
    array will be a IPv4 address.
    EOS
  ) do |arguments|
    require 'resolv'

    Resolv::DNS.new.getresources(arguments[0],Resolv::DNS::Resource::IN::A).collect do |res|
      res.address.to_s
    end
  end
end
