module Puppet::Parser::Functions
  newfunction(:dns_ptr, :type => :rvalue, :arity => 1, :doc => <<-EOS
    Retrieves DNS PTR records and returns it as an array of strings.
    EOS
  ) do |arguments|
    require 'resolv'

    ret = Resolv::DNS.new.getresources(arguments[0],Resolv::DNS::Resource::IN::PTR).map { |r| r.name.to_s }
    raise Resolv::ResolvError, "DNS result has no information for #{arguments[0]}" if ret.empty?
    ret
  end
end
