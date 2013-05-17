include $(TOP)/vendor/intel/baytrail/wifi/WifiRules.mk

BOARD_WIFI_DIR = vendor/intel/baytrail/$(TARGET_DEVICE)/wifi
LOCAL_BOARD_WIFI_DIR = $(PWD)/$(BOARD_WIFI_DIR)

# wifi platform specific configuration files addings
STA_CONF_FILES      += $(LOCAL_BOARD_WIFI_DIR)/$(STA_CONF_FILE_NAME)
P2P_CONF_FILES      += $(LOCAL_BOARD_WIFI_DIR)/$(P2P_CONF_FILE_NAME)
HOSTAPD_CONF_FILES  += $(LOCAL_BOARD_WIFI_DIR)/$(HOSTAPD_CONF_FILE_NAME)

