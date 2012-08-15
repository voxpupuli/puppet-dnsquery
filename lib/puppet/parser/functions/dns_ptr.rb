module Puppet::Parser::Functions
  newfunction(:dns_ptr, :type => :rvalue, :doc => <<-EOS
    Retrieves a DNS PTR record and returns it as a string.
    EOS
  ) do |arguments|
    require 'resolv'

    raise(Puppet::ParseError, "dns_ptr(): Wrong number of arguments " +
          "given (#{arguments.size} for 1)") if arguments.size != 1

    Resolv::DNS.new.getresource(arguments[0],Resolv::DNS::Resource::IN::PTR).name.to_s
  end
end
