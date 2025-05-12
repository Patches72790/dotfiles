return {
    init_options = {
        terraform = {
            path = os.getenv("HOME") .. "/.nix-profile/bin/terraform",
        },
    },
}
