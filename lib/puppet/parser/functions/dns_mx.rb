module Puppet::Parser::Functions
  newfunction(:dns_mx, :type => :rvalue, :arity => -2, :doc => <<-EOS
    Retrieves DNS MX records and returns it as an array. Each record in the
    array will be an array of [preference, exchange] arrays.
    Second argument is optional and can be either 'preference' or 'exchange',
    if supplied an array of only those elements is returned.
    EOS
  ) do |arguments|
    require 'resolv'

    raise(ArgumentError, "dns_mx(): Wrong number of arguments " +
          "given (#{arguments.size} for 2 or 4)") if arguments.size > 4

    if arguments[2].is_a? String
      config_info = {
        :nameserver => arguments[2],
        :search => arguments[3],
        :ndots => 1
      }
    else
      config_info = nil
    end

    ret = Resolv::DNS.new(config_info).getresources(arguments[0],Resolv::DNS::Resource::IN::MX).collect do |res|
      if arguments.size == 1 then
        [res.preference, res.exchange.to_s]
      else
        case arguments[1]
        when 'preference'
          res.preference
        when 'exchange'
          res.exchange.to_s
        else
          raise ArgumentError, "dns_mx(): invalid value #{arguments[1]} for second argument"
        end
      end
    end
    raise Resolv::ResolvError, "DNS result has no information for #{arguments[0]}" if ret.empty?
    ret
  end
end
