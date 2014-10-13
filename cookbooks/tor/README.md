tor Cookbook
============
This cookbook installs and configures a Tor relay

Requirements
------------

#### repositories
- `epel` - Tor is in the EPEL repository

#### packages
- `tor` - ronseal

Attributes
----------

#### tor::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['tor']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### tor::default

Just include `tor` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[tor]"
  ]
}
```

License and Authors
-------------------
GPL 3.0 
Gareth Llewellyn
