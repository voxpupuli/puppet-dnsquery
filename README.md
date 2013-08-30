DNS query functions
===================

This module contains query functions for DNS for use from Puppet.

Usage
-----

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
array will be an array of [preference, exchange] arrays.
Second argument is optional and can be either 'preference' or 'exchange',
if supplied an array of only those elements is returned.

### dns_ptr

Retrieves DNS PTR records and returns it as an array of strings.

### dns_srv

Retrieves DNS SRV records and returns it as an array. Each record in the
array will be an array of [priority, weight, port, target] arrays.
Second argument is optional and can be either 'priority', 'weight', 'port'
or 'target', if supplied an array of only those elements is returned.

### dns_txt

Retrieves DNS TXT records and returns it as an array. Each record in the
array will be a array containing the strings of the TXT record.
