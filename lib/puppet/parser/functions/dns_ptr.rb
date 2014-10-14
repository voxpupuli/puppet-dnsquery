module Puppet::Parser::Functions
  newfunction(:dns_ptr, :type => :rvalue, :arity => 1, :doc => <<-EOS
    Retrieves DNS PTR records and returns it as an array of strings.
    EOS
  ) do |arguments|
    require 'resolv'

    Resolv::DNS.new.getresources(arguments[0],Resolv::DNS::Resource::IN::PTR).map { |r| r.name.to_s }
  end
end
