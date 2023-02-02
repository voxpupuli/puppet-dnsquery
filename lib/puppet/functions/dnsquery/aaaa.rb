# frozen_string_literal: true

# Retrieves DNS AAAA records and returns it as an array. Each record in the
# array will be a IPv6 address.
#
# An optional lambda can be given to return a default value in case the
# lookup fails. The lambda will only be called if the lookup failed.
Puppet::Functions.create_function(:'dnsquery::aaaa') do
  dispatch :dns_aaaa do
    param 'String', :record
  end

  dispatch :dns_aaaa_with_default do
    param 'String', :record
    block_param
  end

  def dns_aaaa(record)
    Resolv::DNS.new.getresources(
      record, Resolv::DNS::Resource::IN::AAAA
    ).map do |res|
      IPAddr.new(res.address.to_s).to_s
    end
  end

  def dns_aaaa_with_default(record)
    ret = dns_aaaa(record)
    if ret.empty?
      yield
    else
      ret
    end
  rescue Resolv::ResolvError
    yield
  end
end
