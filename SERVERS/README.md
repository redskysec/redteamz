

red-phish
ph.agm1.us

red-payload
pl.agm1.us

red-backend {c2c}
c2.agm1.us


redirectors
veil-payload - haproxy ->    pl.agm1.us
veil-c2       traefik ->    c2c.agm1.us
