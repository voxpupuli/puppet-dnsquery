# frozen_string_literal: true

# Retrieves DNS A records and returns it as an array. Each record in the
# array will be a IPv4 address.
#
# An optional lambda can be given to return a default value in case the
# lookup fails. The lambda will only be called if the lookup failed.
Puppet::Functions.create_function(:'dnsquery::a') do
  dispatch :dns_a do
    param 'String', :record
  end

  dispatch :dns_a_with_default do
    param 'String', :record
    block_param
  end

  def dns_a(record)
    Resolv::DNS.new.getresources(
      record, Resolv::DNS::Resource::IN::A
    ).map do |res|
      res.address.to_s
    end
  end

  def dns_a_with_default(record)
    ret = dns_a(record)
    if ret.empty?
      yield
    else
      ret
    end
  rescue Resolv::ResolvError
    yield
  end
end
