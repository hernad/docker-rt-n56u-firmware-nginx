SRC_NAME=nginx-1.9.5

CFLAGS  += -I(STAGEDIR)/include/openssl -ffunction-sections -fdata-sections
CXXFLAGS += -ffunction-sections -fdata-sections
LDFLAGS += -L$(STAGEDIR)/lib -lssl -lcrypto  -Wl,--gc-sections

THISDIR = $(shell pwd)

all: config_test
	$(MAKE) -C $(SRC_NAME)

config_test:
	( if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
		make configure && touch config_done; \
	fi )

#/opt/rt-n56u/toolchain-mipsel/toolchain-3.4.x/bin/mipsel-linux-uclibc-gcc
#/opt/rt-n56u/toolchain-mipsel/toolchain-3.4.x/bin/mipsel-linux-uclibc-gcc

#--with-cc=/opt/rt-n56u/toolchain-mipsel/toolchain-3.4.x/bin/mipsel-linux-uclibc-gcc 
#--with-zlib=$(STAGEDIR)

#--with-openssl=/opt/rt-n56u/trunk/libs/libssl/openssl-1.0.1 


configure:
	( cd $(SRC_NAME) ; \
	./configure --crossbuild=Linux::mips \
	--prefix=/etc/storage/nginx \
	--with-cc=/opt/rt-n56u/toolchain-mipsel/toolchain-3.4.x/bin/mipsel-linux-uclibc-gcc \
	--with-openssl=/opt/local \
	--with-zlib=/opt/local \
	--with-http_ssl_module \
	--error-log-path=/dev/stderr \
	--without-http_rewrite_module ; \
	)


clean:
	if [ -f $(SRC_NAME)/Makefile ] ; then \
		$(MAKE) -C $(SRC_NAME) distclean ; \
	fi ; \
	rm -f config_done
	rm -rf install

romfs:
	$(ROMFSINST) $(SRC_NAME)/objs/nginx /usr/sbin/nginx
	mkdir -p $(INSTALLDIR)/etc/storage/nginx/conf
	mkdir -p $(INSTALLDIR)/etc/storage/nginx/log
	$(ROMFSINST) $(SRC_NAME)/conf/mime.types /etc/storage/nginx/conf 
