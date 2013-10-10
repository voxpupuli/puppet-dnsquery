module Puppet::Parser::Functions
  newfunction(:dns_ptr, :type => :rvalue, :doc => <<-EOS
    Retrieves DNS PTR records and returns it as an array of strings.
    EOS
  ) do |arguments|
    require 'resolv'

    raise(Puppet::ParseError, "dns_ptr(): Wrong number of arguments " +
          "given (#{arguments.size} for 1)") if arguments.size != 1

    Resolv::DNS.new.getresources(arguments[0],Resolv::DNS::Resource::IN::PTR).map { |r| r.name.to_s }
  end
end
