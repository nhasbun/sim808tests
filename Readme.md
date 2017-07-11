# SIM808 Shield Tests #

> Nicolas Hasbún A.
> 12 - 06 - 2017

Here you can find some simple tests for the **SIM808** shield which is very popular for prototyping projects.

**You need a special firmware to use Bluetooth function.** I got the files from this websites:


- [https://www.itead.cc/wiki/SIM808_GSM/GPRS/GPS_Module](https://www.itead.cc/wiki/SIM808_GSM/GPRS/GPS_Module)
- [http://simcom.ee/documents/?dir=SIM808](http://simcom.ee/documents/?dir=SIM808) 

Instructions for flashing could be found [here](https://www.elecrow.com/wiki/index.php?title=How_to_upgrade_firmware_of_Arduino_SIM808_Shield).

**Brand Name**:   DIYmall

**Model Number**: FZ1735

With the shield I got [this link](https://www.adrive.com/public/P7QRkq/FZ1735-SIM808%20%E5%A4%A7V3.1.rar) to get started with the product where you can find some manuals and basic tools.

## GPRS Internet Connection ##

For internet configuration it was enough reading the `SIM800 Series_TCPIP_Application Note_V1.02` document.

For configuring an APN which is using username and password it was useful to read [this webpage](https://wiki.octanis.org/sim800). 

----------

# Interface with Arduino #

> Rodrigo Dattari,
> Antonia Larrañaga,
> Nicolas Hasbún A.
> 11 - 07 - 2017

Regarding folder **rescueRoutine**.

Here we built a simple routine triggered by a button. GPS is constantly saving positions and upon button pressure the last position is sent via SMS to a phone number and the module starts to wait for a call.

This was implemented using the **DFRobot_SIM808** library that I found [here](https://www.dfrobot.com/wiki/index.php/SIM808_GPS/GPRS/GSM_Shield_SKU:_TEL0097#Auto_Answering_Phone_Calls_and_Reading_SMS_Messages). Also used an Arduino UNO R3 and his hardware serial interface.