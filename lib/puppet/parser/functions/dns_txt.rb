module Puppet::Parser::Functions
  newfunction(:dns_txt, :type => :rvalue, :arity => 1, :doc => <<-EOS
    Retrieves DNS TXT records and returns it as an array. Each record in the
    array will be a array containing the strings of the TXT record.
    EOS
  ) do |arguments|
    require 'resolv'

    if arguments[2].is_a? String
      config_info = {
        :nameserver = arguments[3],
        :search = arguments[4],
        :ndots = 1
      }
    else
      config_info = nil
    end

    ret = Resolv::DNS.new(config_info).getresources(arguments[0],Resolv::DNS::Resource::IN::TXT).collect do |res|
      res.strings
    end
    raise Resolv::ResolvError, "DNS result has no information for #{arguments[0]}" if ret.empty?
    ret
  end
end
