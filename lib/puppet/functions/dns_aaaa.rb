# frozen_string_literal: true

# Retrieves DNS AAAA records and returns it as an array. Each record in the
# array will be a IPv6 address.
#
# An optional lambda can be given to return a default value in case the
# lookup fails. The lambda will only be called if the lookup failed.
Puppet::Functions.create_function(:dns_aaaa) do
  dispatch :dns_aaaa do
    param 'String', :record
  end

  dispatch :dns_aaaa_with_default do
    param 'String', :record
    block_param
  end

  def dns_aaaa(record)
    Puppet.deprecation_warning('dns_aaaa', 'This method is deprecated please use the namespaced version dnsquery::aaaa')
    call_function('dnsquery::aaaa', record)
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
