FROM staticfloat/nginx-certbot

# Build-time variables with default values
ARG DOMAIN="C2_DOMAIN_CHANGE_ME"
ARG C2_IP="127.0.0.1"
ARG CERTBOT_EMAIL="CERTBOT_EMAIL_CHANGE_ME@does_not_exist.does_not_exist"

# Set environment variables for use in Nginx config
ENV DOMAIN=${DOMAIN}
ENV C2_IP=${C2_IP}
ENV CERTBOT_EMAIL=${CERTBOT_EMAIL}

# Install envsubst for variable substitution
RUN apt-get update && apt-get install -y gettext-base

# Copy the Nginx configuration template
COPY nginx.conf.template /etc/nginx/conf.d/nginx.conf.template

# Substitute environment variables in the Nginx config template
RUN envsubst '${DOMAIN} ${C2_IP}' < /etc/nginx/conf.d/nginx.conf.template > /etc/nginx/conf.d/default.conf

# Remove the template to avoid confusion
RUN rm /etc/nginx/conf.d/nginx.conf.template

# Copy phony web pages
COPY --chown=www-data:www-data html/* /var/www/html

# Expose necessary ports
EXPOSE 80 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
