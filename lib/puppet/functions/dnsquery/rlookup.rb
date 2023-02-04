# frozen_string_literal: true

# Retrieves results from DNS reverse lookup and returns it as an array.
# Each record in the array will be a hostname.
# An optional lambda can be given to return a default value in case the
# lookup fails. The lambda will only be called if the lookup failed.
Puppet::Functions.create_function(:'dnsquery::rlookup') do
  dispatch :dns_rlookup do
    param 'String', :address
  end

  dispatch :dns_rlookup_with_default do
    param 'String', :address
    block_param
  end

  def dns_rlookup(address)
    addr = IPAddr.new(address)
    Resolv::DNS.new.getresources(
      addr.reverse, Resolv::DNS::Resource::IN::PTR
    ).map do |res|
      res.name.to_s
    end
  end

  def dns_rlookup_with_default(address)
    ret = dns_rlookup(address)
    if ret.empty?
      yield
    else
      ret
    end
  rescue Resolv::ResolvError
    yield
  end
end
