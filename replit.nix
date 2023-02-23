{ pkgs }: {
    deps = [
        pkgs.shfmt
        pkgs.goreman
        pkgs.rclone
        pkgs.curl
        pkgs.jq
        pkgs.jre8_headless
    ];
}
