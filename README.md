# nginx rt-n56u

      /opt/rt-n56u/trunk/user/nginx


## nginx user

     root@c035cc2a582f:/opt/rt-n56u/trunk/user/nginx# ls  
     .git Makefile  README.md  config_done  nginx-1.9.5



## make


     root@c035cc2a582f:/opt/rt-n56u/trunk# rm user/nginx/config_done ; CONFIG_FIRMWARE_INCLUDE_NGINX=y make

<pre>
....
LZMA 4.43 Copyright (c) 1999-2006 Igor Pavlov  2006-06-04
# Padded Kernel Image Size
1219104 /opt/rt-n56u/trunk/images/zImage.lzma
# Original RootFs Size
18628724        /opt/rt-n56u/trunk/romfs
# Compressed RootFs Size
5842227 /opt/rt-n56u/trunk/images/ramdisk
# Padded Kernel Image + Compressed Rootfs Size
7061331 /opt/rt-n56u/trunk/images/zImage.lzma
# !!! Please make sure that Padded Kernel Image + Compressed Rootfs size
# can't bigger than 7995136 !!!
#===========================================
# Pack final image and write headers
# For No padded, need write kernel size in image header to correct mount partition in mtd drivers address
img file: /opt/rt-n56u/trunk/images/RT-N56U_3.4.3.9-096.trx
Product ID:   RT-N56U
Created:      Tue Oct 13 16:10:48 2015
Image Type:   MIPS Linux Kernel Image (lzma compressed)
Data Size:    7061331 Bytes = 6895.83 kB = 6.73 MB
Load Address: 0x80000000
Entry Point:  0x802C1E70
Kernel Size:  0x00129A60
Kernel Ver.:  3.4
FS Ver.:      3.9
make[2]: Leaving directory '/opt/rt-n56u/trunk/vendors/Ralink/RT3883'
make[1]: Leaving directory '/opt/rt-n56u/trunk/vendors'
</pre>


## Makefile CONFIG_FIRMWARE_INCLUDE_NGINX
 
<pre>
diff --git a/trunk/user/Makefile b/trunk/user/Makefile
index cbfba86..405ebc5 100644
--- a/trunk/user/Makefile
+++ b/trunk/user/Makefile
@@ -102,6 +102,7 @@ dir_$(CONFIG_FIRMWARE_INCLUDE_OPENVPN)              += openvpn
 dir_$(CONFIG_FIRMWARE_INCLUDE_XUPNPD)          += xupnpd
 dir_$(CONFIG_FIRMWARE_INCLUDE_TCPDUMP)         += tcpdump
 dir_$(SAMBA_ENABLED)                           += samba3
+dir_$(CONFIG_FIRMWARE_INCLUDE_NGINX)            += nginx
</pre>


