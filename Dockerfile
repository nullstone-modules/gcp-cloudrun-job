FROM alpine:3

USER default
HEALTHCHECK NONE

CMD ["sh", "-c", "echo 'This is a bootstrap image. Deploy a new version to perform work.'; exit 0"]
