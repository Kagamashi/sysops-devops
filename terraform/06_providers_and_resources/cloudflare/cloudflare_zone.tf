
# Provides a Cloudflare Zone resource. Zone is the basic resource for working with Cloudflare 
# and is roughly equivalent to a domain name that the user purchases.

resource "cloudflare_zone" "example" {
  account_id = "f037e56e89293a057740de681ac9abbe"
  zone       = "example.com"
}
