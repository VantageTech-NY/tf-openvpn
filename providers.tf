# Configure the Digital Ocean provider.
provider "digitalocean" {
  token = var.do_token
}

# Configure the Cloudflare provider.
provider "cloudflare" {
  version   = "~> 2.0"
  api_token = var.cloudflare_api_key
}

# Configure the Uptime Robot provider.
provider "uptimerobot" {
  api_key = var.uptimerobot_api_key
}