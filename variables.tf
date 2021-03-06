## Digital Ocean, variables
variable "do_token" {
  description = "API key, generated by user to access Digital Ocean"
  default     = ""
}

variable "do_ssh_key" {
  description = "Setting fingerprint of an ssh key already upladed to Digital Ocean"
  default     = ""
}

## Cloudflare, variables
variable "cloudflare_api_key" {
  description = "Setting the default key needed to access Cloudflare services"
  default     = ""
}

variable "cloudflare_zone_id" {
  description = "Setting the api key to logon to Cloudflare Services"
  default     = ""
}

variable "uptimerobot_api_key" {
  description = "Setting the api key to logon to Uptime Robot Services"
  default     = ""
}

variable "uptimerobot_api_key" {
  description = "DNS name to bind IP to"
  default     = ""
}
