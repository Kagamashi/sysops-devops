
# Tunnel exposes applications running on your local web server on any network with an internet connection 
# without manually adding DNS records or configuring a firewall or router.

resource "cloudflare_zero_trust_tunnel_cloudflared" "example" {
  account_id = "f037e56e89293a057740de681ac9abbe"
  name       = "my-tunnel"
  secret     = "AQIDBAUGBwgBAgMEBQYHCAECAwQFBgcIAQIDBAUGBwg=" # random string used to authenticate the tunnel (can be generated with openssl rand -hex 32).
  config_src = "cloudflare" # manages tunnel via dashboards / terraform
}
