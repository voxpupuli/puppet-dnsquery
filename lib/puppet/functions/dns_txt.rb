# frozen_string_literal: true

# Retrieves DNS TXT records and returns it as an array. Each record in the
# array will be a array containing the strings of the TXT record.
#
# An optional lambda can be given to return a default value in case the
# lookup fails. The lambda will only be called if the lookup failed.
Puppet::Functions.create_function(:dns_txt) do
  dispatch :dns_txt do
    param 'String', :record
  end

  dispatch :dns_txt_with_default do
    param 'String', :record
    block_param
  end

  def dns_txt(record)
    Puppet.deprecation_warning('dns_txt', 'This method is deprecated please use the namespaced version dnsquery::txt')
    call_function('dnsquery::txt', record)
  end

  def dns_txt_with_default(record)
    ret = dns_txt(record)
    if ret.empty?
      yield
    else
      ret
    end
  rescue Resolv::ResolvError
    yield
  end
end
