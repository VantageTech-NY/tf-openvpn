data "digitalocean_ssh_key" "ssh_key" {
  name = var.do_ssh_key
}

# Create a new Droplet in the nyc3 region
resource "digitalocean_droplet" "openvpn_as" {
  image    = "openvpn-18-04"
  name     = "OpenVPN-2-8-5-NYC3"
  region   = "nyc3"
  size     = "s-1vcpu-1gb"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.fingerprint]
}

resource "digitalocean_firewall" "openvpn_fw" {
  name = "openvpn"

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "943"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "53"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

# Add A record pointing to vps
resource "cloudflare_record" "vpn_dns" {
  zone_id = var.cloudflare_zone_id
  name    = var.dns_name
  value   = digitalocean_droplet.openvpn_as.ipv4_address
  type    = "A"
}

resource "uptimerobot_monitor" "openvpn_monitor" {
  friendly_name = "vps-vpn"
  type          = "http"
  url           = "https://${var.dns_name}"
  # 300 seconds is the min monitoring level
  interval = 300
}
