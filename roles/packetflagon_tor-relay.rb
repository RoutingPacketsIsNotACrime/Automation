name "packetflagon_tor-relay"
description "Deploys a Tor Relay"
run_list(
"recipe[tor]",
"recipe[twofactor]",
"recipe[users]"
)
override_attributes({
})
