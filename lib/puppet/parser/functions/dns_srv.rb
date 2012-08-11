module Puppet::Parser::Functions
  newfunction(:dns_srv, :type => :rvalue, :doc => <<-EOS
    Retrieves DNS SRV records and returns it as an array. Each record in the
    array will be an array of [priority, weight, port, target] arrays.
    Second argument is optional and can be either 'priority', 'weight', 'port'
    or 'target', if supplied an array of only those elements is returned.
    EOS
  ) do |arguments|
    require 'resolv'

    raise(Puppet::ParseError, "dns_srv(): Wrong number of arguments " +
          "given (#{arguments.size} for 1 or 2)") if arguments.size < 1 or arguments.size > 2

    result = Resolv::DNS.new.getresources(arguments[0],Resolv::DNS::Resource::IN::SRV)

    result.each.collect do |res|
      if arguments.size == 1 then
        [res.priority, res.weight, res.port, res.target]
      else
        begin
          res.send(arguments[1])
        rescue
          raise Puppet::ParseError "dns_srv(): invalid value #{arguments[1]} for second argument"
        end
      end
    end
  end
end
