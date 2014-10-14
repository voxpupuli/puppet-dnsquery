module Puppet::Parser::Functions
  newfunction(:dns_cname, :type => :rvalue, :arity => 1, :doc => <<-EOS
    Retrieves a DNS CNAME record and returns it as a string.
    EOS
  ) do |arguments|
    require 'resolv'

    Resolv::DNS.new.getresource(arguments[0],Resolv::DNS::Resource::IN::CNAME).name.to_s
  end
end
