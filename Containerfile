# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY system_files /files
COPY build_files /build_files

# Base Image
FROM ghcr.io/ublue-os/bazzite:stable

RUN --mount=type=tmpfs,dst=/tmp \
  --mount=type=bind,from=ctx,source=/,target=/run/context \
  mkdir -p /var/roothome && \
  /run/context/build_files/build.sh && \
  ostree container commit
    
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
