DEVICE_PATH := device/lava/LXX503

# Soong namespace
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# Virtual A/B - Keep these for partition mounting logic
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

PRODUCT_USE_DYNAMIC_PARTITIONS := true
AB_OTA_UPDATER := true
ENABLE_VIRTUAL_AB := true

# Define A/B partitions
AB_OTA_PARTITIONS += \
    boot \
    vendor_boot \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    system \
    system_ext \
    product 
    
# Configure emulated_storage.mk (Required for /sdcard)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enable Fuse Passthrough for performance
PRODUCT_PROPERTY_OVERRIDES += persist.sys.fuse.passthrough.enable=true

# Boot control (recovery only)
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-mtkimpl.recovery \
    bootctrl.mt6833 \
    create_pl_dev.recovery

# (Optional) sideload only
PRODUCT_PACKAGES += \
    update_engine_sideload

# Otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(DEVICE_PATH)/security/LXX503_releasekey

