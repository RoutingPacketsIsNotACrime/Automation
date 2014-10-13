squid Cookbook
==============
This cookbook is used to deploy additional PacketFlagon.is Squid instances to help spread load and screw with the censors.

It includes the cron jobs to fetch the ACL lists from the API

Requirements
------------

#### packages
- `squid` - Obviously
- `iwstats` - For reporting back the bandwidth usage

Attributes
----------

e.g.
#### squid::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['squid']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### squid::default

Just include `squid` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[squid]"
  ]
}
```

Contributing
------------
Contributions are always welcome;

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Submit a Pull Request using Github

License and Authors
-------------------
GPL 3.0
Gareth Llewellyn
