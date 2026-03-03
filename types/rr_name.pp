# @summary type used for resource record names
#
# The name must comply with RFC2181:
#
# > The DNS itself places only one restriction on the particular labels
# > that can be used to identify resource records.  That one restriction
# > relates to the length of the label and the full name.  The length of
# > any one label is limited to between 1 and 63 octets.  A full domain
# > name is limited to 255 octets (including the separators).  The zero
# > length full name is defined as representing the root of the DNS tree,
# > and is typically written and displayed as ".".  Those restrictions
# > aside, any binary string whatever can be used as the label of any
# > resource record.
type Dnsquery::Rr_name = String[1, 255]
