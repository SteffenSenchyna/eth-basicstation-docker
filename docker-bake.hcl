variable "TAG" { default = "" }
variable "VERSION" { default = "" }
variable "BUILD_DATE" { default = "" }
variable "REGISTRY" { default = "ssenchyn/basicstation" }
variable "REMOTE_TAG" { default = "v2.0.6" }
variable "VARIANT" { default = "stdn" }

group "default" {
  targets = ["armv7hf", "aarch64", "amd64"]
}

target "armv7hf" {
  tags = ["${REGISTRY}:armv7hf-latest"]
  args = {
    "ARCH"       = "armv7hf",
    "REMOTE_TAG" = "${REMOTE_TAG}",
    "VARIANT"    = "${VARIANT}",
    "TAG"        = "${TAG}",
    "VERSION"    = "${VERSION}",
    "BUILD_DATE" = "${BUILD_DATE}"
  }
  platforms = ["linux/arm/v7"]
}

target "aarch64" {
  tags = ["${REGISTRY}:aarch64-latest"]
  args = {
    "ARCH"       = "aarch64",
    "REMOTE_TAG" = "${REMOTE_TAG}",
    "VARIANT"    = "${VARIANT}",
    "TAG"        = "${TAG}",
    "VERSION"    = "${VERSION}",
    "BUILD_DATE" = "${BUILD_DATE}"
  }
  platforms = ["linux/arm64"]
}

target "amd64" {
  tags = ["${REGISTRY}:amd64-latest"]
  args = {
    "ARCH"       = "amd64",
    "REMOTE_TAG" = "${REMOTE_TAG}",
    "VARIANT"    = "${VARIANT}",
    "TAG"        = "${TAG}",
    "VERSION"    = "${VERSION}",
    "BUILD_DATE" = "${BUILD_DATE}"
  }
  platforms = ["linux/amd64"]
}
