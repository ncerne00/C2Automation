#!/bin/bash

# Export variables from terraform
export C2_SERVER_IP="${c2_server_ip}"
export REDIRECTOR_DOMAIN_NAME="${redirector_domain_name}"
export APPROVED_USER_AGENT="${approved_user_agent}"

# Function to check if the domain resolves
check_dns_resolution() {
    if command -v dig &> /dev/null; then
        dig +short $REDIRECTOR_DOMAIN_NAME | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' &> /dev/null
    elif command -v nslookup &> /dev/null; then
        nslookup $REDIRECTOR_DOMAIN_NAME 2>/dev/null | grep -E 'Address: [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' &> /dev/null
    else
        echo "Neither dig nor nslookup found! Cannot check DNS resolution."
        return 1
    fi
}

# Wait for domain resolution (max 5 minutes)
echo "Waiting for DNS resolution of $REDIRECTOR_DOMAIN_NAME..."
MAX_WAIT=300  # 5 minutes
INTERVAL=10   # Check every 10 seconds
WAITED=0

while ! check_dns_resolution; do
    if [ "$WAITED" -ge "$MAX_WAIT" ]; then
        echo "ERROR: Domain $REDIRECTOR_DOMAIN_NAME did not resolve within 5 minutes."
        exit 1
    fi
    echo "Still waiting for $REDIRECTOR_DOMAIN_NAME to resolve..."
    sleep $INTERVAL
    WAITED=$((WAITED + INTERVAL))
done

echo "✅ $REDIRECTOR_DOMAIN_NAME successfully resolved!"

# Detect Linux Distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
elif command -v lsb_release &> /dev/null; then
    OS=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
elif [ -f /etc/redhat-release ]; then
    OS="rhel"
else
    echo "Unsupported Linux distribution"
    exit 1
fi

echo "Detected OS: $OS"

# Install dependencies based on OS
case "$OS" in
    ubuntu|debian)
        apt update -y
        apt install -y nginx certbot python3-certbot-nginx
        ;;
    amzn|amazon)
        yum install -y nginx certbot python3-certbot-nginx
        ;;
    centos|rhel)
        yum install -y epel-release
        yum install -y nginx certbot python3-certbot-nginx
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
esac

# Write the Nginx config templates
cat <<EOF > /etc/nginx/conf.d/ssl.conf
server {
    listen 443 ssl;
    server_name $REDIRECTOR_DOMAIN_NAME;

    ssl_certificate /etc/letsencrypt/live/$REDIRECTOR_DOMAIN_NAME/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$REDIRECTOR_DOMAIN_NAME/privkey.pem;

    location / {
EOF

# Check if `APPROVED_USER_AGENT` is set and apply filtering only if provided
if [[ -n "$APPROVED_USER_AGENT" ]]; then
    echo '        if ($http_user_agent !~* "'"$APPROVED_USER_AGENT"'") { return 403; }' >> /etc/nginx/conf.d/ssl.conf
    echo "User-Agent filtering enabled: Only allowing $APPROVED_USER_AGENT"
else
    echo "User-Agent filtering disabled: Forwarding all traffic"
fi

# Continue Nginx configuration
cat <<EOF >> /etc/nginx/conf.d/ssl.conf
        proxy_pass https://$C2_SERVER_IP:443;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

# forward MTLS traffic blindly
cat <<EOF > /etc/nginx/conf.d/mtls.conf
server {
    listen 8888 ssl;
    server_name $REDIRECTOR_DOMAIN_NAME;

    ssl_certificate /etc/letsencrypt/live/$REDIRECTOR_DOMAIN_NAME/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$REDIRECTOR_DOMAIN_NAME/privkey.pem;

    location / {
        proxy_pass https://$C2_SERVER_IP:8888;
        proxy_set_header Host \$host;
    }
}
EOF

# Request SSL certificate (force non-interactive)
certbot certonly --standalone -d $REDIRECTOR_DOMAIN_NAME --non-interactive --agree-tos -m admin@$REDIRECTOR_DOMAIN_NAME

# Restart Nginx
systemctl restart nginx