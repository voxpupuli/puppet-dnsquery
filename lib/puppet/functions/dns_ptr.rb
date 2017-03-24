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
    Resolv::DNS.new.getresources(
      record, Resolv::DNS::Resource::IN::PTR
    ).collect do |res|
      res.name.to_s
    end
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
