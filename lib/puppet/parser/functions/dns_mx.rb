module Puppet::Parser::Functions
  newfunction(:dns_mx, :type => :rvalue, :doc => <<-EOS
    Retrieves DNS MX records and returns it as an array. Each record in the
    array will be an array of [preference, exchange] arrays.
    Second argument is optional and can be either 'preference' or 'exchange',
    if supplied an array of only those elements is returned.
    EOS
  ) do |arguments|
    require 'resolv'

    raise(Puppet::ParseError, "dns_mx(): Wrong number of arguments " +
          "given (#{arguments.size} for 1 or 2)") if arguments.size < 1 or arguments.size > 2

    result = Resolv::DNS.new.getresources(arguments[0],Resolv::DNS::Resource::IN::MX)

    result.each.collect do |res|
      if arguments.size == 1 then
        [res.preference, res.exchange]
      else
        begin
          res.send(arguments[1])
        rescue
          raise Puppet::ParseError "dns_mx(): invalid value #{arguments[1]} for second argument"
        end
      end
    end
  end
end

