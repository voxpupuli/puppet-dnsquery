# dns_lookup.rb
# does a DNS lookup and returns an array of strings of the results

module Puppet::Parser::Functions
  newfunction(:dns_lookup, :type => :rvalue, :arity => 1, :doc => <<-EOS
    Does a DNS lookup and returns an array of addresses.
    EOS
  ) do |arguments|
    require 'resolv'

    res = Resolv::DNS.new
    arg = arguments[0]

    if arg.is_a? Array
      arg.collect { |e| res.getaddresses(e).to_s }.flatten
    else
      res.getaddresses(arg).collect { |r| r.to_s }
    end
  end
end
