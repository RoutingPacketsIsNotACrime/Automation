twofactor Cookbook
==================
Install various Yubico software (e.g. lib_yubico) and changes ssh / sudo to make use of the yubikey

Requirements
------------
A yubikey and ssh keys

e.g.
#### packages
- `pam_yubico` - Allows yubikeys to be used with pam supportable auth

Attributes
----------
#### twofactor::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['twofactor']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### twofactor::default

Just include `twofactor` in your node's `run_list` and ensure the users databag has a yubikey section.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[twofactor]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
6. Submit a Pull Request using Github

License and Authors
-------------------
GPL 3.0
Gareth Llewellyn
