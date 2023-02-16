# frozen_string_literal: true

# Retrieves DNS MX records and returns it as an array. Each record in the
# array will be an array of hashes with a preference and exchange field.
#
# An optional lambda can be given to return a default value in case the
# lookup fails. The lambda will only be called if the lookup failed.
Puppet::Functions.create_function(:dns_srv) do
  dispatch :dns_srv do
    param 'String', :record
  end

  dispatch :dns_srv_with_default do
    param 'String', :record
    block_param
  end

  def dns_srv(record)
    Puppet.deprecation_warning('dns_srv', 'This method is deprecated please use the namespaced version dnsquery::srv')
    call_function('dnsquery::srv', record)
  end

  def dns_srv_with_default(record)
    ret = dns_srv(record)
    if ret.empty?
      yield
    else
      ret
    end
  rescue Resolv::ResolvError
    yield
  end
end
