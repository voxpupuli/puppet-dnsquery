module Puppet::Parser::Functions
  newfunction(:dns_txt, :type => :rvalue, :arity => 1, :doc => <<-EOS
    Retrieves DNS TXT records and returns it as an array. Each record in the
    array will be a array containing the strings of the TXT record.
    EOS
  ) do |arguments|
    require 'resolv'

    Resolv::DNS.new.getresources(arguments[0],Resolv::DNS::Resource::IN::TXT).collect do |res|
      res.strings
    end
  end
end
