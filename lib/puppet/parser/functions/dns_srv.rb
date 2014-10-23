module Puppet::Parser::Functions
  newfunction(:dns_srv, :type => :rvalue, :arity => -2, :doc => <<-EOS
    Retrieves DNS SRV records and returns it as an array. Each record in the
    array will be an array of [priority, weight, port, target] arrays.
    Second argument is optional and can be either 'priority', 'weight', 'port'
    or 'target', if supplied an array of only those elements is returned.
    EOS
  ) do |arguments|
    require 'resolv'

    raise(ArgumentError, "dns_srv(): Wrong number of arguments " +
          "given (#{arguments.size} for 1 or 2)") if arguments.size > 2

    ret = Resolv::DNS.new.getresources(arguments[0],Resolv::DNS::Resource::IN::SRV).collect do |res|
      if arguments.size == 1 then
        [res.priority, res.weight, res.port, res.target.to_s]
      else
        case arguments[1]
        when 'priority', 'weight', 'port'
          res.send(arguments[1])
        when 'target'
          res.target.to_s
        else
          raise ArgumentError, "dns_srv(): invalid value #{arguments[1]} for second argument"
        end
      end
    end
    raise Resolv::ResolvError, "DNS result has no information for #{arguments[0]}" if ret.empty?
    ret
  end
end
