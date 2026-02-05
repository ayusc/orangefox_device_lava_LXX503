DEVICE_PATH := device/lava/LXX503

# Virtual A/B - Keep these for partition mounting logic
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

PRODUCT_USE_DYNAMIC_PARTITIONS := true
AB_OTA_UPDATER := true
ENABLE_VIRTUAL_AB := true

# Define A/B partitions so recovery knows what to slot-switch
AB_OTA_PARTITIONS += \
    boot \
    vendor_boot \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    system \
    system_ext \
    product \
    vendor 

# Configure emulated_storage.mk (Required for /sdcard)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enable Fuse Passthrough for performance
PRODUCT_PROPERTY_OVERRIDES += persist.sys.fuse.passthrough.enable=true

# Minimal Boot Control HAL (Essential for A/B switching)
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-mtkimpl.recovery \
    bootctrl.mt6833 \
    libgptutils \
    checkpoint_gc \
    create_pl_dev.recovery

# Essential Crypto/FBE support 
PRODUCT_PACKAGES += \
    libkeymaster4 \
    libkeymaster41 \
    android.hardware.keymaster@4.0 \
    android.hardware.gatekeeper@1.0-impl \
    gatekeeper.default \
    kmsetkey.beanpod

# Copy manifest (required for decryption + logo hang fix)
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery/root/system/etc/vintf/manifest.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/vintf/manifest.xml
