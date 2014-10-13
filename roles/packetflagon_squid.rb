name "packetflagon_squid"
description "Deploys a PacketFlagon Squid Proxy"
run_list(
"recipe[squid]",
"recipe[twofactor]",
"recipe[users]"
)
override_attributes({
})
