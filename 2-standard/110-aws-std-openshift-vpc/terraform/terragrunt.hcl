terraform {
    # Connect to VPN if required for terraform (checks the bom.yaml)
    before_hook "stop_vpn" {
        commands        = ["destroy"]
        execute         = ["bash", "../stop-vpn.sh"]
        run_on_error    = true
    }
}