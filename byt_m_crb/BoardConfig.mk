# Name of the reference design
# Should be changed with the original values when starting customization
REF_DEVICE_NAME ?= $(TARGET_DEVICE)
REF_PRODUCT_NAME ?= $(TARGET_PRODUCT)

TARGET_USE_DROIDBOOT := true

STORAGE_CFLAGS := -DSTORAGE_BASE_PATH=\"/dev/block/sda\" -DSTORAGE_PARTITION_FORMAT=\"%s%d\"

# serialno
USE_BL_SERIALNO := true

TARGET_OS_SIGNING_METHOD := isu_plat2

include $(PLATFORM_PATH)/BoardConfig.mk

# Disable sparse build until we move to B-2 and re-use ethernet PCI card
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

# IAFW component to build for this board
BOARD_IAFW_COMPONENT := brd_bayleybay

#Platform
BOARD_USES_48000_AUDIO_CAPTURE_SAMPLERATE_FOR_WIDI := true

# Connectivity
ifeq (, $(filter %_next, $(TARGET_PRODUCT)))
BOARD_HAVE_WIFI := true
BOARD_HAVE_BLUETOOTH := true
FLASHFILE_NO_OTA := false
else
#disable BT for kernel_next bringup
BOARD_HAVE_WIFI := true
BOARD_HAVE_BLUETOOTH := false
FLASHFILE_NO_OTA := true
endif

# Connectivity
BOARD_HAVE_MODEM := false
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_CONF_PATH)
TARGET_HAS_VPP := true
TARGET_VPP_USE_GEN := true
COMMON_GLOBAL_CFLAGS += -DGFX_BUF_EXT
# MultiDisplay service
TARGET_HAS_MULTIPLE_DISPLAY := true
USE_MDS_LEGACY := true

USE_INTEL_IPP := true

# Power_HAL
POWERHAL_BYT := true

# Widi
INTEL_WIDI := true
INTEL_WIDI_BAYTRAIL := true

# Audio
BOARD_USES_ALSA_AUDIO := true
BOARD_USES_TINY_ALSA_AUDIO := true
BOARD_USES_AUDIO_HAL_CONFIGURABLE := true
BOARD_USE_VIBRATOR := true
BUILD_WITH_ALSA_UTILS := true
BOARD_USES_GENERIC_AUDIO := false

#GEN is one graphic and video engine
# Baytrail uses the GEN for the graphic and video
BOARD_GRAPHIC_IS_GEN := true

# Camera
# Set USE_CAMERA_STUB to 'true' for Fake Camera builds,
# 'false' for libcamera builds to use Camera Imaging(CI) supported by intel.
USE_CAMERA_STUB := false
USE_CAMERA_HAL2 := false
USE_CAMERA_USB := true

USE_INTEL_METABUFFER := true

USE_CSS_2_0 := true

# Enabled HW accelerated JPEG encoder using VA API
USE_INTEL_JPEG := false
# Enabled NXP Premium Audio Effect Libraries
#USE_INTEL_LVSE := true

ifeq ($(BOARD_KERNEL_CMDLINE),)
ifeq ($(TARGET_BUILD_VARIANT),eng)
BOARD_KERNEL_CMDLINE := console=ttyS0,115200 console=logk0 earlyprintk=nologger loglevel=8 drm.debug=0x0 kmemleak=off ptrace.ptrace_can_access=1 androidboot.bootmedia=$(BOARD_BOOTMEDIA) androidboot.hardware=$(TARGET_DEVICE) $(cmdline_extra) nmi_watchdog=panic softlockup_panic=1 vmalloc=172M crashkernel=64M@256M
else ifeq ($(TARGET_BUILD_VARIANT),userdebug)
BOARD_KERNEL_CMDLINE := console=ttyS0,115200 console=logk0 earlyprintk=nologger loglevel=4 kmemleak=off ptrace.ptrace_can_access=1 androidboot.bootmedia=$(BOARD_BOOTMEDIA) androidboot.hardware=$(TARGET_DEVICE) $(cmdline_extra) nmi_watchdog=panic softlockup_panic=1 vmalloc=172M
else
BOARD_KERNEL_CMDLINE := console=logk0 earlyprintk=nologger loglevel=0 kmemleak=off androidboot.bootmedia=$(BOARD_BOOTMEDIA) androidboot.hardware=$(TARGET_DEVICE) $(cmdline_extra) vmalloc=172M
endif
endif

# Graphics
BOARD_GPU_DRIVERS := i965
USE_OPENGL_RENDERER := true
BOARD_KERNEL_CMDLINE += vga=current i915.modeset=1 drm.vblankoffdelay=1 \
                        acpi_backlight=vendor

BOARD_USES_LIBPSS := false

INTEL_VA:=true
USE_INTEL_VA:=true
BOARD_USES_WRS_OMXIL_CORE:=true
BOARD_USES_MRST_OMX:=true
USE_INTEL_ASF_EXTRACTOR:=true
# enabled to use hardware VP8 decoder
USE_HW_VP8 := true

BOARD_USE_LIBVA_INTEL_DRIVER := true
BOARD_USE_LIBVA := true
BOARD_USE_LIBMIX := true

#Support background music playback for Widi Multitasking
ENABLE_BACKGROUND_MUSIC := true

# Settings for the Media SDK library and plug-ins:
# - USE_MEDIASDK: use Media SDK support or not
# - MFX_IPP: sets IPP library optimization to use
USE_MEDIASDK := true
# Enable CIP Codecs
USE_INTEL_MDP := true
MFX_IPP := p8
# enabled to use Intel audio SRC (sample rate conversion)
USE_INTEL_SRC := true
# enabled to use ALAC
USE_FEATURE_ALAC := true

# Defines Intel library for GPU accelerated Renderscript:
OVERRIDE_RS_DRIVER := libRSDriver_intel7.so

#temporary workaround to speed up flashing with fastboot
BOARD_KERNEL_DROIDBOOT_EXTRA_CMDLINE += droidboot.disablefbootui=1

# usb stick/sdcard installer support
BOARD_KERNEL_DROIDBOOT_EXTRA_CMDLINE +=  droidboot.use_installer=1 droidboot.installer_usb=/dev/block/sdb1 droidboot.installer_sdcard=/dev/block/mmcblk1p1 droidboot.installer_file=installer.cmd

#Camera
ADDITIONAL_BUILD_PROPERTIES += \
				ro.camera.number=1 \
				ro.camera.0.devname=/dev/video0 \
				ro.camera.0.facing=front \
				ro.camera.0.orientation=0

#Set ro.adb.secure to 0 for user build
ifeq ($(TARGET_BUILD_VARIANT), user)
ADDITIONAL_DEFAULT_PROPERTIES += \
                                ro.adb.secure=0
endif
