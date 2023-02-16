# frozen_string_literal: true

# Retrieves DNS MX records and returns it as an array. Each record in the
# array will be an array of hashes with a preference and exchange field.
#
# An optional lambda can be given to return a default value in case the
# lookup fails. The lambda will only be called if the lookup failed.
Puppet::Functions.create_function(:dns_mx) do
  dispatch :dns_mx do
    param 'String', :record
  end

  dispatch :dns_mx_with_default do
    param 'String', :record
    block_param
  end

  def dns_mx(record)
    Puppet.deprecation_warning('dns_mx', 'This method is deprecated please use the namespaced version dnsquery::mx')
    call_function('dnsquery::mx', record)
  end

  def dns_mx_with_default(record)
    ret = dns_mx(record)
    if ret.empty?
      yield
    else
      ret
    end
  rescue Resolv::ResolvError
    yield
  end
end
