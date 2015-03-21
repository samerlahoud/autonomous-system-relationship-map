# Table of Contents #


# Objective #
This project aims to provide a tool for drawing relationship maps between Autonomous Systems in the Internet.

Autonomous Systems can have three types of relationships as introduced by [L. Gao](http://portal.acm.org/citation.cfm?id=504616):
  * customer-to-provider (c2p) (or if looked at from the opposite direction, provider-to-customer p2c),
  * peer-to-peer (p2p), and
  * sibling-to-sibling (s2s)

# Data Collection #
The software tool uses public data collection provided by [CAIDA](http://www.caida.org/home/) :
  * [AS information](http://as-rank.caida.org/?mode0=as-dump-info) containing the following information AS number|source|AS name|country|org name|date.
  * [Relationship data](http://as-rank.caida.org/?mode0=as-dump-peercones) (containing the following information as0 | as1 | type where type is -1 for a customer relationship, and 0 for a peering relationship)
  * [AS name to number mapping](http://www.caida.org/data/request_user_info_forms/as_relationships.xml)

# Screenshots #
An output example is given hereafter for AS 2200 i.e., RENATER. Note from the arrow direction that RENATER is a provider for FR-RENATER-IRISA and is a customer of LEVEL3 or GEANT.

![http://samerlahoud.free.fr/as-renater.png](http://samerlahoud.free.fr/as-renater.png)

# Small Tutorial #
Use this command to generate an AS map for a country identified by the [ISO country code:](http://www.iso.org/iso/english_country_names_and_code_elements)

```
perl gen-as-graph.pl cc FR
```

Use this command to generate an AS map for an autonomous system identified by
[its number:](http://bgp.potaroo.net/cidr/autnums.html)
```
perl gen-as-graph.pl asn 2200
```

The output is a file in the dot format you can view with any [compatible software](http://www.graphviz.org/)

# Use Cases #
This tool is used to generate AS maps available at [addroute.lahoud.fr](http://addroute.lahoud.fr)