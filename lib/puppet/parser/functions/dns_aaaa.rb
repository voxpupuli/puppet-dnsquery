module Puppet::Parser::Functions
  newfunction(:dns_aaaa, :type => :rvalue, :arity => 1, :doc => <<-EOS
    Retrieves DNS AAAA records and returns it as an array. Each record in the
    array will be a IPv6 address.
    EOS
  ) do |arguments|
    require 'resolv'

    if arguments[2].is_a? String
      config_info = {
        :nameserver => arguments[2],
        :search => arguments[3],
        :ndots => 1
      }
    else
      config_info = nil
    end

    ret = Resolv::DNS.new(config_info).getresources(arguments[0],Resolv::DNS::Resource::IN::AAAA).collect do |res|
      res.address.to_s
    end
    raise Resolv::ResolvError, "DNS result has no information for #{arguments[0]}" if ret.empty?
    ret
  end
end
