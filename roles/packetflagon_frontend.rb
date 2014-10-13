name "packetflagon_frontend"
description "Deploys a PacketFlagon PAC serving frontend (aka a Shard)"
run_list(
"recipe[frontend::shard]",
"recipe[twofactor]",
"recipe[users]"
)
override_attributes({
})
