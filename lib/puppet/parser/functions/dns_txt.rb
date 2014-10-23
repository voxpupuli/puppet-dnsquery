module Puppet::Parser::Functions
  newfunction(:dns_txt, :type => :rvalue, :arity => 1, :doc => <<-EOS
    Retrieves DNS TXT records and returns it as an array. Each record in the
    array will be a array containing the strings of the TXT record.
    EOS
  ) do |arguments|
    require 'resolv'

    ret = Resolv::DNS.new.getresources(arguments[0],Resolv::DNS::Resource::IN::TXT).collect do |res|
      res.strings
    end
    raise Resolv::ResolvError, "DNS result has no information for #{arguments[0]}" if ret.empty?
    ret
  end
end
