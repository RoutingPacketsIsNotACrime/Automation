name "packetflagon_chef-server"
description "Deploys two-factor ssh etc to a chef server"
run_list (
["recipe[twofactor]","recipe[users]"
]
)
override_attributes({
})
