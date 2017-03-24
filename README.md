DNS query functions
===================

This module contains query functions for DNS for use from Puppet.

Usage
-----

All functions can take a optional second lambda argument that is called if the lookup returned no values. Then the result of the lambda will be used instead.

### dns_lookup

Does a DNS lookup and returns an array of addresses.

### dns_a

Retrieves DNS A records and returns it as an array. Each record in the
array will be a IPv4 address.

### dns_aaaa

Retrieves DNS AAAA records and returns it as an array. Each record in the
array will be a IPv6 address.

### dns_cname

Retrieves a DNS CNAME record and returns it as a string.

### dns_mx

Retrieves DNS MX records and returns it as an array. Each record in the
array will be an array of hashes containing a `preference` & `exchange` key.

### dns_ptr

Retrieves DNS PTR records and returns it as an array of strings.

### dns_srv

Retrieves DNS SRV records and returns it as an array. Each record in the
array will be an array of hashes containing a `priority`, `weight`, `port` and `target` key.

### dns_txt

Retrieves DNS TXT records and returns it as an array. Each record in the
array will be a array containing the strings of the TXT record.
