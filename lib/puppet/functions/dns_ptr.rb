# frozen_string_literal: true

# Retrieves DNS A records and returns it as an array. Each record in the
# array will be a IPv4 address.
# An optional lambda can be given to return a default value in case the
# lookup fails. The lambda will only be called if the lookup failed.
Puppet::Functions.create_function(:dns_ptr) do
  dispatch :dns_ptr do
    param 'String', :record
  end

  dispatch :dns_ptr_with_default do
    param 'String', :record
    block_param
  end

  def dns_ptr(record)
    Puppet.deprecation_warning('dns_ptr', 'This method is deprecated please use the namespaced version dnsquery::ptr')
    call_function('dnsquery::ptr', record)
  end

  def dns_ptr_with_default(record)
    ret = dns_ptr(record)
    if ret.empty?
      yield
    else
      ret
    end
  rescue Resolv::ResolvError
    yield
  end
end
