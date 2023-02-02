# Retrieves DNS TXT records and returns it as an array. Each record in the
# array will be a array containing the strings of the TXT record.
#
# An optional lambda can be given to return a default value in case the
# lookup fails. The lambda will only be called if the lookup failed.
Puppet::Functions.create_function(:'dnsquery::soa') do
  dispatch :dns_soa do
    param 'String', :record
  end

  dispatch :dns_soa_with_default do
    param 'String', :record
    block_param
  end

  def dns_soa(record)
    res = Resolv::DNS.new.getresource(
      record, Resolv::DNS::Resource::IN::SOA
    )
    {
      'expire'  => res.expire,
      'minimum' => res.minimum,
      'mname'   => res.mname,
      'refresh' => res.refresh,
      'retry'   => res.retry,
      'rname'   => res.rname,
      'serial'  => res.serial,
    }
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
