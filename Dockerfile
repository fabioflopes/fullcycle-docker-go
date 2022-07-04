FROM golang AS gobuilder

WORKDIR /var/www/app
COPY . /var/www/app

RUN useradd fullcycle

RUN go mod init fullcycle/app

RUN go build .

RUN chown -R fullcycle:fullcycle /var/www

FROM scratch

WORKDIR /var/www/
COPY --from=gobuilder /etc/passwd /etc/passwd
COPY --from=gobuilder /var/www/app .
USER fullcycle

ENTRYPOINT ["./app"]