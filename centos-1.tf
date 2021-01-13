data "digitalocean_ssh_key" "joeyengel" {
  name = "joeyengel"
}

resource "digitalocean_droplet" "centos-1" {
    #image = "ubuntu-18-04-x64"
    image = "centos-8-x64"
    name = "centos-1"
    region = "nyc1"
    size = "s-1vcpu-1gb"
    private_networking = true
    ssh_keys = [
      data.digitalocean_ssh_key.joeyengel.id
    ]

  #connection {
  #  host = self.ipv4_address
  #  user = "root"
  #  type = "ssh"
  #  private_key = file(var.pvt_key)
  #  timeout = "2m"
  #}

  #provisioner "remote-exec" {
    #inline = [
    #  "export PATH=$PATH:/usr/bin",
    #  # install nginx
    #  "sudo dnf update",
    #  "sudo dnf -y install git jq wget ncdu tree",
    #  "systemctl disable firewalld",
    #  "systemctl stop firewalld"
    #]
  #}

}

# FloatingIP already created; tfapply/tfdestroy will only assign/rm ip from droplet 
resource "digitalocean_floating_ip_assignment" "floatip" {
  #ip_address = digitalocean_floating_ip.floatip.ip_address
  ip_address = "174.138.125.179" 
  droplet_id = digitalocean_droplet.centos-1.id
}
