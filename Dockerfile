# 
FROM quay.io/spivegin/gitonly:latest AS git

FROM dart:3.7.3
WORKDIR /opt/gcx
RUN ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa && git config --global user.name "quadtone" && git config --global user.email "quadtone@txtsme.com"
COPY --from=git /root/.ssh /root/.ssh
#ADD https://github.com/caddyserver/caddy/releases/download/v2.5.1/caddy_2.5.1_linux_amd64.tar.gz /opt/gcx/
ENV deploy=c1f18aefcb3d1074d5166520dbf4ac8d2e85bf41 

RUN ssh-keyscan -H github.com > ~/.ssh/known_hosts &&\
    ssh-keyscan -H gitlab.com >> ~/.ssh/known_hosts &&\
    ssh-keyscan -H gitea.com >> ~/.ssh/know_hosts &&\
    ssh-keyscan -H api.smsburr.com >> ~/.ssh/know_hosts

RUN git config --global url.git@github.com:.insteadOf https://github.com/ &&\
    git config --global url.git@gitlab.com:.insteadOf https://gitlab.com/ &&\
    git config --global url.git@gitea.com:.insteadOf https://gitea.com/ &&\
    git config --global url."https://${deploy}@sc.tpnfc.us/".insteadOf "https://sc.tpnfc.us/"

CMD [ "bash" ]