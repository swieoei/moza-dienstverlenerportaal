# Statische NLDD-mockup geserveerd door nginx (unprivileged: draait als non-root,
# luistert op poort 8080 — past bij Kubernetes-platforms zoals Quattro/RIG).
FROM nginxinc/nginx-unprivileged:1.27-alpine

# Cache-Control: no-cache op alle pagina's — browsers revalideren altijd en
# blijven nooit hangen op een verouderde (of verkeerd geroutéerde) index.
COPY nginx-default.conf /etc/nginx/conf.d/default.conf

# Alleen de statische site; build-/repo-bestanden blijven buiten het image (.dockerignore).
COPY index.html login.html sso.html /usr/share/nginx/html/

EXPOSE 8080
