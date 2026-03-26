# SonarQube Community Edition (LTS) — official image
# Extend here to add plugins: COPY into /opt/sonarqube/extensions/plugins/ as root, then chown to sonarqube
FROM sonarqube:lts-community

EXPOSE 9000
