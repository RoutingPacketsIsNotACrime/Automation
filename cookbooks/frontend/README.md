frontend Cookbook
=================
The (yet to be fully realised) power of the PacketFlagon.is platform is that anyone can host a ProxyShard which allows an unlimited number of PAC serving frontends that call back to the PacketFlagon.is API.

This will enable people to fight ISP URL and virtual host blocking by hosting this lightweight app on any available http(s) FQDN they have available.

They can't censor everyone.

Requirements
------------

#### packages
- `php` - All the code is based on PHP
- `memcached` - If running a standalone platform
- `mysql` - If running a standalone platform

Attributes
----------

#### frontend::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['frontend']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### frontend::default
To deploy just include `frontend` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[frontend::shard]"
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

You can also suggest ideas by raising GitHub issues or email Security@RoutingPacketsIsNotACrime.uk
License and Authors
-------------------
GPL 3.0
Gareth Llewellyn
