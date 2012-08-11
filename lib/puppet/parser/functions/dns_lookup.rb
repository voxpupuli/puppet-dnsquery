# dns_lookup.rb
# does a DNS lookup and returns an array of strings of the results

module Puppet::Parser::Functions
  newfunction(:dns_lookup, :type => :rvalue, :doc => <<-EOS
    Does a DNS lookup and returns an array of addresses.
    EOS
  ) do |arguments|
    require 'resolv'

    Resolv::DNS.new.getaddresses(arguments[0])
  end
end
