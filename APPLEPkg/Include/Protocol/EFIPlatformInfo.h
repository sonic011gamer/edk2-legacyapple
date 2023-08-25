/** 
  @file  EFIPlatformInfo.h
  @brief PlatformInfo Protocol for UEFI.
*/
/*=============================================================================
  Copyright (c) 2011-2012 Qualcomm Technologies, Incorporated.
  All rights reserved.
  Qualcomm Technologies, Confidential and Proprietary.
=============================================================================*/

/*=============================================================================
                              EDIT HISTORY


 when       who     what, where, why
 --------   ---     -----------------------------------------------------------
 06/18/13   llg     (Tech Pubs) Edited/added Doxygen comments and markup.
 05/08/12   vishalo Merge in Techpubs Doxygen change
 05/04/12   llg     (Tech Pubs) Edited/added Doxygen comments and markup.
 01/26/12   vishalo Merge in Techpubs Doxygen change
 10/25/11   llg     (Tech Pubs) Edited/added Doxygen comments and markup.
 03/07/11   mdt     Created.

=============================================================================*/


#ifndef __EFIPLATFORMINFO_H__
#define __EFIPLATFORMINFO_H__

/*===========================================================================
  INCLUDE FILES
===========================================================================*/

/*===========================================================================
  MACRO DECLARATIONS
===========================================================================*/
/** @addtogroup efi_platformInfo_constants 
@{ */
/**
  Protocol version.
*/
#define EFI_PLATFORMINFO_PROTOCOL_VERSION 0x0000000000020000
/** @} */ /* end_addtogroup efi_platformInfo_constants */

/*  Protocol GUID definition */
/** @ingroup efi_platformInfo_protocol */
#define EFI_PLATFORMINFO_PROTOCOL_GUID \
  { 0x157a5c45, 0x21b2 , 0x43c5, { 0xba, 0x7c, 0x82, 0x2f, 0xee, 0x5f, 0xe5, 0x99 } }


/** @cond */
/*===========================================================================
  EXTERNAL VARIABLES
===========================================================================*/
/**
  External reference to the Platform Info Protocol GUID.
 */
extern EFI_GUID gEfiPlatformInfoProtocolGuid;

/*===========================================================================
  TYPE DEFINITIONS
===========================================================================*/
/**
  Protocol declaration.
 */
typedef struct _EFI_PLATFORMINFO_PROTOCOL EFI_PLATFORMINFO_PROTOCOL;
/** @endcond */

/** @addtogroup efi_platformInfo_data_types 
@{ */
/**
  Target type of the device on which the platform is running.
*/
typedef enum
{
  EFI_PLATFORMINFO_TYPE_UNKNOWN     = 0x00,  /**< Unknown target device. */
  EFI_PLATFORMINFO_TYPE_SURF        = 0x01,  /**< Subscriber unit reference device. */
  EFI_PLATFORMINFO_TYPE_FFA         = 0x02,  /**< Form-fit accurate device. */
  EFI_PLATFORMINFO_TYPE_FLUID       = 0x03,  /**< Forward looking user interface 
                                            demonstration device. */
  EFI_PLATFORMINFO_TYPE_FUSION      = 0x04,  /**< Fusion device. */
  EFI_PLATFORMINFO_TYPE_OEM         = 0x05,  /**< Original equipment manufacturer 
                                                  device. */
  EFI_PLATFORMINFO_TYPE_QT          = 0x06,  /**< Qualcomm tablet device. */
  EFI_PLATFORMINFO_TYPE_CDP         = EFI_PLATFORMINFO_TYPE_SURF, 
                                             /**< CDP (a.k.a. SURF) device. */
  EFI_PLATFORMINFO_TYPE_MTP_MDM     = 0x07,  /**< MDM MTP device. */
  EFI_PLATFORMINFO_TYPE_MTP_MSM     = 0x08,  /**< MSM@tm MTP device. */
  EFI_PLATFORMINFO_TYPE_MTP         = EFI_PLATFORMINFO_TYPE_MTP_MSM,
  EFI_PLATFORMINFO_TYPE_LIQUID      = 0x09,  /**< LiQUID device. */
  EFI_PLATFORMINFO_TYPE_DRAGONBOARD = 0x0A,  /**< DragonBoard@tm device. */
  EFI_PLATFORMINFO_TYPE_QRD         = 0x0B,  /**< QRD device. */
  EFI_PLATFORMINFO_TYPE_EVB         = 0x0C,  /**< EVB device. */
  EFI_PLATFORMINFO_TYPE_HRD         = 0x0D,  /**< HRD device. */
  EFI_PLATFORMINFO_TYPE_DTV         = 0x0E,  /**< DTV device. */
  EFI_PLATFORMINFO_TYPE_RUMI        = 0x0F,  /**< Target is on Rumi (ASIC emulation). */
  EFI_PLATFORMINFO_TYPE_VIRTIO      = 0x10,  /**< Target is on Virtio (system-level simulation). */
  EFI_PLATFORMINFO_TYPE_GOBI        = 0x11,  /**< Gobi@tm device. */
  EFI_PLATFORMINFO_TYPE_CBH         = 0x12,  /**< CBH device. */
  EFI_PLATFORMINFO_TYPE_BTS         = 0x13,  /**< BTS device. */
  EFI_PLATFORMINFO_TYPE_XPM         = 0x14,  /**< XPM device. */
  EFI_PLATFORMINFO_TYPE_RCM         = 0x15,  /**< RCM device. */
  EFI_PLATFORMINFO_TYPE_DMA         = 0x16,  /**< DMA device. */
  EFI_PLATFORMINFO_TYPE_STP         = 0x17,  /**< STP device. */
  EFI_PLATFORMINFO_TYPE_SBC         = 0x18,  /**< SBC device. */
  EFI_PLATFORMINFO_TYPE_ADP         = 0x19,  /**< ADP device. */
  EFI_PLATFORMINFO_TYPE_CHI         = 0x1A,  /**< CHI device. */

  EFI_PLATFORMINFO_NUM_TYPES, /**< Number of known targets
                                   (including unknown). @newpage */
  /** @cond */
  EFI_PLATFORMINFO_TYPE_32BITS      = 0x7FFFFFFF
  /** @endcond */
} EFI_PLATFORMINFO_PLATFORM_TYPE;


/**
 * Keys to get data out of the CDT.
 */
typedef enum
{
  EFI_PLATFORMINFO_KEY_UNKNOWN       = 0x00,
  EFI_PLATFORMINFO_KEY_DDR_FREQ      = 0x01,
  EFI_PLATFORMINFO_KEY_GFX_FREQ      = 0x02,
  EFI_PLATFORMINFO_KEY_CAMERA_FREQ   = 0x03,
  EFI_PLATFORMINFO_KEY_FUSION        = 0x04,
  EFI_PLATFORMINFO_KEY_CUST          = 0x05,

  EFI_PLATFORMINFO_NUM_KEYS          = 0x06,

  /** @cond */
  EFI_PLATFORMINFO_KEY_32BITS  = 0x7FFFFFFF
  /** @endcond */
} EFI_PLATFORMINFO_KEY_TYPE;


/**
  Stores the target platform, the platform version, and the subtype of the
  platform.
 */
typedef struct
{
  EFI_PLATFORMINFO_PLATFORM_TYPE    platform;
  /**< Type of the current target; see #EFI_PLATFORMINFO_PLATFORM_TYPE for 
       details. */
  UINT32                            version;
  /**< Version of the platform in use. */
  UINT32                            subtype;
  /**< Subtype of the platform. */
  BOOLEAN                           fusion;
  /**< TRUE if Fusion; FALSE otherwise. */
} EFI_PLATFORMINFO_PLATFORM_INFO_TYPE;
/** @} */ /* end_addtogroup efi_platformInfo_data_types */


/*===========================================================================
  FUNCTION DEFINITIONS
===========================================================================*/
/* EFI_PLATFORMINFO_GET_PLATFORMINFO */ 
/** @ingroup efi_platformInfo_get_platformInfo
  @par Summary
  Gets information about the current platform. The information is returned 
  in the PlatformInfo parameter.

  @param[in]  This          Pointer to the EFI_PLATFORMINFO_PROTOCOL instance.
  @param[out] PlatformInfo  Pointer to the platform information to be filled 
                            in; see #EFI_PLATFORMINFO_PLATFORM_INFO_TYPE.

  @return
  EFI_SUCCESS        -- Function completed successfully.  \n
  EFI_PROTOCOL_ERROR -- Error occurred during the operation. 
*/
typedef
EFI_STATUS
(EFIAPI *EFI_PLATFORMINFO_GET_PLATFORMINFO)(
  IN  EFI_PLATFORMINFO_PROTOCOL           *This,
  OUT EFI_PLATFORMINFO_PLATFORM_INFO_TYPE *PlatformInfo); 


/* EFI_PLATFORMINFO_GET_KEYVALUE */ 
/** @ingroup efi_platformInfo_get_platformInfo
  @par Summary
  Gets a key value.

  @param[in]  This          Pointer to the EFI_PLATFORMINFO_PROTOCOL instance.
  @param[in]  Key           Key to get the value for; 
                            see #EFI_PLATFORMINFO_KEY_TYPE.
  @param[out] Value         Key value.

  @return
  EFI_SUCCESS        -- Key found.  \n
  EFI_NOT_FOUND      -- Key not found.  \n
  EFI_INVALID_PARAMETER -- Key out of range or Value is NULL.
*/
typedef
EFI_STATUS
(EFIAPI *EFI_PLATFORMINFO_GET_KEYVALUE)(
  IN  EFI_PLATFORMINFO_PROTOCOL   *This,
  IN  EFI_PLATFORMINFO_KEY_TYPE    Key,
  OUT UINT32                      *Value); 


/*===========================================================================
  PROTOCOL INTERFACE
===========================================================================*/
/** @ingroup efi_platformInfo_protocol
  @par Summary
  Platform Information Protocol interface.

  @par Parameters
  @inputprotoparams{platform_info_proto_params.tex} 
*/
struct _EFI_PLATFORMINFO_PROTOCOL {
  UINT64                            Version;
  EFI_PLATFORMINFO_GET_PLATFORMINFO GetPlatformInfo;  
  EFI_PLATFORMINFO_GET_KEYVALUE     GetKeyValue;
};

#endif  /* __EFIPLATFORMINFO_H__ */
