deadhand Cookbook
=================
The PacketFlagon deadhand system is quite simple;
1. Checks if the latest registered URL has been blocked by ISP censors
2. If censored a new URL is registered via Gandi
3. A new 512Mb VM is spun up at DigitalOcean (some ISPs will block all SSL traffic to an IP that hosts a censored website)
4. The VM is bootstrapped to host the new ProxyShard
5. Tweets out the that the new URL will soon be available

The actual PacketFlagon.is deadhand protocol has a few other tricks up its sleeves including pre-paid accounts that enable this system to run autonomously till 2025!

Requirements
------------
CentOS
PHP
CURL
Knife config + SSH key
Blocked.org.uk API Key
Gandi.net API Key
DigitalOcean API Key
Twitter API Key / OAUTH etc

e.g.
#### packages
- `php` - The current generation of the script relies on php and curl

Attributes
----------

#### deadhand::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['deadhand']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### deadhand::default

Just include `deadhand` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[deadhand]"
  ]
}
```

Then set all the attributes you can see in the template call

Contributing
------------
If you want to help make the DeadHand scripts a bit more robust (since it's a hack at the moment) feel free to help;

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Submit a Pull Request using Github

License and Authors
-------------------
GPL 3.0
Gareth Llewellyn
