DEVICE_PATH := device/lava/LXX503

# Soong namespace
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# Virtual A/B - Keep these for partition mounting logic
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

PRODUCT_USE_DYNAMIC_PARTITIONS := true
AB_OTA_UPDATER := true
ENABLE_VIRTUAL_AB := true
PRODUCT_FULL_TREBLE_OVERRIDE := true

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
    
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/mtk_plpath_utils \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

# Configure emulated_storage.mk (Required for /sdcard)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enable Fuse Passthrough for performance
PRODUCT_PROPERTY_OVERRIDES += persist.sys.fuse.passthrough.enable=true

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Minimal Boot Control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-mtkimpl \
    android.hardware.boot@1.2-mtkimpl.recovery \
    bootctrl.mt6833 \
    checkpoint_gc \
    create_pl_dev \
    create_pl_dev.recovery

# Essential Crypto/FBE support 
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0 \
    android.hardware.keymaster@4.1 

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier \
    otapreopt_script

# Otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(DEVICE_PATH)/security/LXX503_releasekey
