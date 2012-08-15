module Puppet::Parser::Functions
  newfunction(:dns_txt, :type => :rvalue, :doc => <<-EOS
    Retrieves DNS TXT records and returns it as an array. Each record in the
    array will be a array containing the strings of the TXT record.
    EOS
  ) do |arguments|
    require 'resolv'

    raise(Puppet::ParseError, "dns_txt(): Wrong number of arguments " +
          "given (#{arguments.size} for 1)") if arguments.size != 1

    Resolv::DNS.new.getresources(arguments[0],Resolv::DNS::Resource::IN::TXT).collect do |res|
      res.strings
    end
  end
end
