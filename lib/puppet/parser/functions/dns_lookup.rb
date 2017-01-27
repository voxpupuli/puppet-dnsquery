# dns_lookup.rb
# does a DNS lookup and returns an array of strings of the results

module Puppet::Parser::Functions
  newfunction(:dns_lookup, :type => :rvalue, :arity => 1, :doc => <<-EOS
    Does a DNS lookup and returns an array of addresses.
    EOS
  ) do |arguments|
    require 'resolv'

    if arguments[2].is_a? String
      config_info = {
        :nameserver = arguments[2],
        :search = arguments[3],
        :ndots = 1
      }
    else
      config_info = nil
    end

    res = Resolv::DNS.new(config_info)
    arg = arguments[0]

    ret = if arg.is_a? Array
      arg.collect { |e| res.getaddresses(e).map(&:to_s) }.flatten
    else
      res.getaddresses(arg).collect { |r| r.to_s }
    end
    raise Resolv::ResolvError, "DNS result has no information for #{arg}" if ret.empty?
    ret
  end
end
