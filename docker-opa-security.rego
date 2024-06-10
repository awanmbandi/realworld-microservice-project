package main

# Do Not store secrets in ENV variables
secrets_env = [
    "passwd",
    "password",
    "pass",
    "secret",
    "key",
    "access",
    "api_key",
    "apikey",
    "token",
    "tkn"
]

deny[msg] {
    input[i].Cmd == "env"
    val := input[i].Value
    contains(lower(val[_]), secrets_env[_])
    msg = sprintf("Line %d: Potential secret in ENV key found: %s", [i, val])
}

pass[msg] {
    input[i].Cmd == "env"
    not deny[_]
    msg = "No secrets in ENV variables found."
}

# Only use trusted base images
deny[msg] {
    input[i].Cmd == "from"
    val := split(input[i].Value[0], "/")
    count(val) > 1
    msg = sprintf("Line %d: use a trusted base image", [i])
}

pass[msg] {
    input[i].Cmd == "from"
    not deny[_]
    msg = "Trusted base image used."
}

# Do not use 'latest' tag for base images
deny[msg] {
    input[i].Cmd == "from"
    val := split(input[i].Value[0], ":")
    contains(lower(val[1]), "latest")
    msg = sprintf("Line %d: do not use 'latest' tag for base images", [i])
}

pass[msg] {
    input[i].Cmd == "from"
    not deny[_]
    msg = "No 'latest' tag for base images."
}

# Avoid curl bashing
deny[msg] {
    input[i].Cmd == "run"
    val := concat(" ", input[i].Value)
    matches := regex.find_n("(curl|wget)[^|^>]*[|>]", lower(val), -1)
    count(matches) > 0
    msg = sprintf("Line %d: Avoid curl bashing", [i])
}

pass[msg] {
    input[i].Cmd == "run"
    not deny[_]
    msg = "No curl bashing detected."
}

# Do not upgrade your system packages
warn[msg] {
    input[i].Cmd == "run"
    val := concat(" ", input[i].Value)
    matches := regex.match(".*?(apk|yum|dnf|apt|pip).+?(install|[dist-|check-|group]?up[grade|date]).*", lower(val))
    matches == true
    msg = sprintf("Line: %d: Do not upgrade your system packages: %s", [i, val])
}

pass[msg] {
    input[i].Cmd == "run"
    not warn[_]
    msg = "No system package upgrades detected."
}

# Do not use ADD if possible
deny[msg] {
    input[i].Cmd == "add"
    msg = sprintf("Line %d: Use COPY instead of ADD", [i])
}

pass[msg] {
    input[i].Cmd == "add"
    not deny[_]
    msg = "No ADD command found."
}

# Any user...
any_user {
    input[i].Cmd == "user"
}

deny[msg] {
    not any_user
    msg = "Do not run as root, use USER instead"
}

pass[msg] {
    any_user
    not deny[_]
    msg = "User directive found."
}

# ... but do not root
forbidden_users = [
    "root",
    "toor",
    "0"
]

deny[msg] {
    command := "user"
    users := [name | input[i].Cmd == "user"; name := input[i].Value]
    lastuser := users[count(users)-1]
    contains(lower(lastuser[_]), forbidden_users[_])
    msg = sprintf("Line %d: Last USER directive (USER %s) is forbidden", [i, lastuser])
}

pass[msg] {
    command := "user"
    users := [name | input[i].Cmd == "user"; name := input[i].Value]
    lastuser := users[count(users)-1]
    not contains(lower(lastuser[_]), forbidden_users[_])
    msg = "No forbidden users detected."
}

# Do not sudo
deny[msg] {
    input[i].Cmd == "run"
    val := concat(" ", input[i].Value)
    contains(lower(val), "sudo")
    msg = sprintf("Line %d: Do not use 'sudo' command", [i])
}

pass[msg] {
    input[i].Cmd == "run"
    not deny[_]
    msg = "No 'sudo' command found."
}

# Use multi-stage builds
default multi_stage = false
multi_stage = true {
    input[i].Cmd == "copy"
    val := concat(" ", input[i].Flags)
    contains(lower(val), "--from=")
}
deny[msg] {
    multi_stage == false
    msg = sprintf("You COPY, but do not appear to use multi-stage builds...", [])
}

pass[msg] {
    multi_stage == true
    msg = "Multi-stage builds detected."
}
