module Puppet::Parser::Functions
  newfunction(:dns_cname, :type => :rvalue, :arity => 1, :doc => <<-EOS
    Retrieves a DNS CNAME record and returns it as a string.
    EOS
  ) do |arguments|
    require 'resolv'

    if arguments[2].is_a? String
      config_info = {
        :nameserver = arguments[2],
        :search = arguments[3],
        :ndots = 1
      }
    else
      config_info = nil
    end

    Resolv::DNS.new(config_info).getresource(arguments[0],Resolv::DNS::Resource::IN::CNAME).name.to_s
  end
end
