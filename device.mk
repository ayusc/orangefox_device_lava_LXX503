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
    dpm \
    dtbo \
    gz \
    lk \
    logo \
    mcupm \
    md1img \
    pi_img \
    preloader \
    product \
    scp \
    spmfw \
    sspm \
    system \
    tee \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor

# Configure emulated_storage.mk (Required for /sdcard)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enable Fuse Passthrough for performance
PRODUCT_PROPERTY_OVERRIDES += persist.sys.fuse.passthrough.enable=true

# Minimal Boot Control HAL
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

# Health Hal
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# MTK PlPath Utils
PRODUCT_PACKAGES += \
    mtk_plpath_utils.recovery

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client \
    bootctl

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# Keystore2
PRODUCT_PACKAGES += \
    android.system.keystore2 \

# Otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(DEVICE_PATH)/security/LXX503_releasekey
