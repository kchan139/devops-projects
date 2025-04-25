# SSH Remote Server Setup 
Setup a basic remote linux server and configure it to allow SSH.

## 1. Register and Set Up a Remote Linux Server

### Using DigitalOcean:
1. Create an account at digitalocean.com
2. Create a new Droplet (their virtual server)
   - Choose Ubuntu LTS (20.04 or 22.04)
   - Select the basic plan ($5-6/month)
   - Choose a datacenter region close to you
   - Add your initial SSH key during setup (optional)

## 2. Create SSH Key Pairs

### On Your Local Machine:

Generate first key pair:
```
ssh-keygen -t ed25519 -f ~/.ssh/server_key1
```

Generate second key pair:
```
ssh-keygen -t ed25519 -f ~/.ssh/server_key2
```

## 3. Add SSH Keys to Your Server

### Method 1: During Server Creation
If using DigitalOcean, you can add your public key during droplet creation.

### Method 2: After Server Setup
Connect to your server using password or initial SSH key:
```
ssh root@your-server-ip
```

Add the public keys to the server:
```
mkdir -p ~/.ssh
echo "your-public-key-1-content" >> ~/.ssh/authorized_keys
echo "your-public-key-2-content" >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

## 4. Configure SSH Client

Edit `~/.ssh/config` on your local machine:
```
Host myserver
    HostName your-server-ip
    User root
    IdentityFile ~/.ssh/server_key1

Host myserver2
    HostName your-server-ip
    User root
    IdentityFile ~/.ssh/server_key2
```

## 5. Test Connections

Connect using the first key:
```
ssh -i ~/.ssh/server_key1 root@your-server-ip
```
Or using the alias:
```
ssh myserver
```

Connect using the second key:
```
ssh -i ~/.ssh/server_key2 root@your-server-ip
```
Or using the alias:
```
ssh myserver2
```

## 6. Security Enhancements (Recommended)

### Install fail2ban (Stretch Goal)
```
apt update
apt install fail2ban
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```

Edit configuration:
```
nano /etc/fail2ban/jail.local
```

Enable SSH protection:
```
[sshd]
enabled = true
bantime = 3600
findtime = 600
maxretry = 5
```

Restart fail2ban:
```
systemctl restart fail2ban
```

### Additional SSH Security
Edit `/etc/ssh/sshd_config`:
```
PasswordAuthentication no
PermitRootLogin prohibit-password
```

Restart SSH:
```
systemctl restart sshd
```