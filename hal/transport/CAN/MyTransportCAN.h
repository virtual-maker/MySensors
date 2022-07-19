/*
 * The MySensors Arduino library handles the wireless radio link and protocol
 * between your home built sensors/actuators and HA controller of choice.
 * The sensors forms a self healing radio network with optional repeaters. Each
 * repeater and gateway builds a routing tables in EEPROM which keeps track of the
 * network topology allowing messages to be routed to nodes.
 *
 * Created by Henrik Ekblad <henrik.ekblad@mysensors.org>
 * Copyright (C) 2013-2022 Sensnology AB
 * Full contributor list: https://github.com/mysensors/MySensors/graphs/contributors
 *
 * Documentation: http://www.mysensors.org
 * Support Forum: http://forum.mysensors.org
 *
 * CAN bus transport added by Adam Slovik <your-email-here> // TODO
 * Copyright (C) 2022 Adam Slovik
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * version 2 as published by the Free Software Foundation.
 */

/**
* @file MyTransportCAN.h
*
* @defgroup CANgrp CAN
* @ingroup internals
* @{
*
* CAN driver-related log messages, format: [!]SYSTEM:[SUB SYSTEM:]MESSAGE
* - [!] Exclamation mark is prepended in case of error
*
* |E| SYS | SUB  | Message                         | Comment
* |-|-----|------|---------------------------------|---------------------------------------------------------------------
* | | CAN | INIT | CS=%%d,INT=%%d,SPE=%%d",CLK=%%d | Initialise CAN MCP2515 module radio, chip select (CS),
  | |     |      |                                 | interrupt pin (INT), CAN speed (SPE), CAN clock (CLK)
* |!| CAN | XYZ  | <MESSAGE>                       | TODO: add and comment all CAN debug messages
*
*/

bool _initFilters();
bool transportInit(void);

void _cleanSlot(uint8_t slot);

uint8_t _findCanPacketSlot();

uint8_t _findCanPacketSlot(long unsigned int from, long unsigned int currentPart,
                           long unsigned int messageId);

bool transportSend(const uint8_t to, const void* data, const uint8_t len, const bool noACK);

bool transportDataAvailable(void);

uint8_t transportReceive(void* data);

void transportSetAddress(const uint8_t address);

uint8_t transportGetAddress(void);

bool transportSanityCheck(void);

void transportPowerDown(void);

void transportPowerUp(void);

void transportSleep(void);

void transportStandBy(void);

int16_t transportGetSendingRSSI(void);

int16_t transportGetReceivingRSSI(void);

int16_t transportGetSendingSNR(void);

int16_t transportGetReceivingSNR(void);

int16_t transportGetTxPowerPercent(void);

int16_t transportGetTxPowerLevel(void);

bool transportSetTxPowerPercent(const uint8_t powerPercent);
