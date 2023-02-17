{ pkgs }: {
    deps = [
        pkgs.shfmt
        pkgs.goreman
        pkgs.rclone
        pkgs.jre8
        pkgs.curl
        pkgs.jq
    ];
}