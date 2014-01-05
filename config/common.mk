SUPERUSER_EMBEDDED := true
SUPERUSER_PACKAGE_PREFIX := com.android.settings.cyanogenmod.superuser

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
ifneq ($(WITH_GMS),true)
PRODUCT_COPY_FILES += \
    vendor/mahdi/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/mahdi/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/mahdi/prebuilt/common/bin/50-mahdi.sh:system/addon.d/50-mahdi.sh \
    vendor/mahdi/prebuilt/common/bin/blacklist:system/addon.d/blacklist
endif

# init.d support
PRODUCT_COPY_FILES += \
    vendor/mahdi/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/mahdi/prebuilt/common/bin/sysinit:system/bin/sysinit

# userinit support
PRODUCT_COPY_FILES += \
    vendor/mahdi/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/mahdi/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Mahdi-specific init file
PRODUCT_COPY_FILES += \
    vendor/mahdi/prebuilt/common/etc/init.mahdi.rc:root/init.mahdi.rc

# Compcache/Zram support
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/bin/compcache:system/bin/compcache \
    vendor/cm/prebuilt/common/bin/handle_compcache:system/bin/handle_compcache

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/mahdi/prebuilt/common/etc/mkshrc:system/etc/mkshrc

# Xposed Framework Installer
PRODUCT_COPY_FILES += \
    vendor/mahdi/proprietary/XposedInstaller.apk:system/app/XposedInstaller.apk

# Xposed AppSettings
PRODUCT_COPY_FILES += \
    vendor/mahdi/proprietary/XposedAppSettings.apk:system/app/XposedAppSettings.apk

# Sunbeam Livewallpaper apk
#PRODUCT_COPY_FILES +=  \
#    vendor/mahdi/prebuilt/common/app/SunBeam.apk:system/app/SunBeam.apk

# Gesture enabled JNI for IME
PRODUCT_COPY_FILES += \
    vendor/mahdi/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so

# T-Mobile theme engine
include vendor/mahdi/config/themes_common.mk

# Required Mahdi packages
PRODUCT_PACKAGES += \
    Development \
    LatinIME \
    BluetoothExt

# Optional CM packages
PRODUCT_PACKAGES += \
    Apollo \
    CMFileManager \
    libcyanogen-dsp \
    DSPManager \
    libemoji \
    VoicePlus

# Mahdi packages
PRODUCT_PACKAGES += \
    audio_effects.conf \
    Basic \
    MahdiCenter \
    libscreenrecorder \
    ScreenRecorder \
    SoundRecorder \
    VoiceDialer

# Stock AOSP packages
PRODUCT_PACKAGES += \
    Launcher3 \
    CellBroadcastReceiver

# Extra tools in Mahdi
PRODUCT_PACKAGES += \
    bash \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    vim \
    nano \
    htop \
    powertop \
    lsof \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)

PRODUCT_PACKAGES += \
    procmem \
    procrank \
    Superuser \
    su

# Terminal Emulator
PRODUCT_COPY_FILES += \
    vendor/mahdi/proprietary/Term.apk:system/app/Term.apk \
    vendor/mahdi/proprietary/lib/armeabi/libjackpal-androidterm4.so:system/lib/libjackpal-androidterm4.so

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=1
else

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=0

endif

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/mahdi/overlay/common
PRODUCT_PACKAGE_OVERLAYS += vendor/mahdi/overlay/dictionaries

# Inherit common product build prop overrides
-include vendor/mahdi/config/common_versions.mk