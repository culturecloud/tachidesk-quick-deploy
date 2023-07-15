{ pkgs }: {
    deps = [
        pkgs.lz4
        pkgs.shfmt
        pkgs.goreman
        pkgs.rclone
        pkgs.curl
        pkgs.jq
        pkgs.jre8_headless
    ];
}
