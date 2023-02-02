# Retrieves DNS TXT records and returns it as an array. Each record in the
# array will be a array containing the strings of the TXT record.
#
# An optional lambda can be given to return a default value in case the
# lookup fails. The lambda will only be called if the lookup failed.
Puppet::Functions.create_function(:dns_soa) do
  dispatch :dns_soa do
    param 'String', :record
  end

  dispatch :dns_soa_with_default do
    param 'String', :record
    block_param
  end

  def dns_soa(record)
    Puppet.deprecation_warning('dns_soa', 'This method is deprecated please use the namspaced version dnsquery::soa')
    call_function('dnsquery::soa', record)
  end

  def dns_soa_with_default(record)
    ret = dns_soa(record)
    if ret.empty?
      yield
    else
      ret
    end
  rescue Resolv::ResolvError
    yield
  end
end
