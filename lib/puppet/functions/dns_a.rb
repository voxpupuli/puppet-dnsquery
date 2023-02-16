# frozen_string_literal: true

# Retrieves DNS A records and returns it as an array. Each record in the
# array will be a IPv4 address.
#
# An optional lambda can be given to return a default value in case the
# lookup fails. The lambda will only be called if the lookup failed.
Puppet::Functions.create_function(:dns_a) do
  dispatch :dns_a do
    param 'String', :record
  end

  dispatch :dns_a_with_default do
    param 'String', :record
    block_param
  end

  def dns_a(record)
    Puppet.deprecation_warning('dns_a', 'This method is deprecated please use the namespaced version dnsquery::a')
    call_function('dnsquery::a', record)
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
