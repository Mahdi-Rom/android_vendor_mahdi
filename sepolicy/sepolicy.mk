#
# This policy configuration will be used by all products
#

BOARD_SEPOLICY_DIRS += \
    vendor/mahdi/sepolicy

BOARD_SEPOLICY_UNION += \
    file.te \
    file_contexts \
    fs_use \
    genfs_contexts \
    seapp_contexts \
    mac_permissions.xml
