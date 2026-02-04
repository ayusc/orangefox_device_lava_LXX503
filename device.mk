LOCAL_PATH := device/lava/LXX503

# Virtual A/B
ENABLE_VIRTUAL_AB := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service 

PRODUCT_PACKAGES += \
    bootctrl.mt6833

PRODUCT_PACKAGES += \
    bootctrl.mt6833 \
    libgptutils \
    libz \
    libcutils

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload 

# Keymaster & Gatekeeper blobs for FBE decryption support
PRODUCT_PACKAGES += \
    libkeymaster4 \
    libkeymaster41 \
    libkeymaster4support \
    libkeymaster_messages \
    android.hardware.keymaster@4.0 \
    android.hardware.keymaster@4.1 \
    vendor.mediatek.hardware.keymaster_attestation@1.0 \
    vendor.mediatek.hardware.keymaster_attestation@1.1 \
    android.hardware.gatekeeper@1.0-impl \
    gatekeeper.default \
    kmsetkey.beanpod \
    libSoftGatekeeper
