ARG ARCH
ARG TAG
ARG VERSION
ARG BUILD_DATE
ARG REMOTE_TAG
ARG VARIANT

# Builder image
FROM balenalib/${ARCH}-debian:bookworm-build AS builder
ARG ARCH
ARG REMOTE_TAG
ARG VARIANT

# Switch to working directory for our app
WORKDIR /app

# Checkout and compile remote code
COPY builder/build ./
COPY builder/patches ./patches
RUN chmod +x build
RUN ARCH=${ARCH} REMOTE_TAG=${REMOTE_TAG} VARIANT=${VARIANT} ./build

# Runner image
FROM balenalib/${ARCH}-debian:bookworm-run AS runner
ARG ARCH
ARG TAG
ARG VERSION
ARG BUILD_DATE
ARG REMOTE_TAG
ARG VARIANT

# Image metadata
LABEL maintainer="Xose Pérez <xose.perez@gmail.com>"
LABEL authors="Jose Marcelino, Marc Pous, Xose Pérez and Semtech"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=${BUILD_DATE}
LABEL org.label-schema.name="LoRaWAN Basics™ Station"
LABEL org.label-schema.version="${VERSION} based on ${REMOTE_TAG}-${VARIANT}"
LABEL org.label-schema.description="LoRaWAN gateway with Basics™ Station Packet Forward protocol"
LABEL org.label-schema.vcs-type="Git"
LABEL org.label-schema.vcs-url="https://github.com/xoseperez/basicstation-docker"
LABEL org.label-schema.vcs-ref=${TAG}
LABEL org.label-schema.arch=${ARCH}
LABEL org.label-schema.license="BSD License 2.0"
LABEL io.balena.features.balena-api="1"

# Install required runtime packages
RUN install_packages jq vim gpiod socat

# Switch to working directory for our app
WORKDIR /app

# Copy files from builder and repo
RUN mkdir ./artifacts
COPY --from=builder /app/basicstation/build-rpi-${VARIANT}/bin ./artifacts/v2
COPY --from=builder /app/basicstation/build-corecell-${VARIANT}/bin ./artifacts/corecell
COPY --from=builder /app/basicstation/build-linuxpico-${VARIANT}/bin ./artifacts/picocell
COPY runner/* ./
COPY config ./config
RUN chmod +x start gateway_eui find_concentrator

# Add application folder to path
ENV PATH="${PATH}:/app"

# Launch our binary on container startup.
CMD ["start"]
