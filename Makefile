SRC_NAME=nginx-1.9.5

CFLAGS  += -ffunction-sections -fdata-sections
CXXFLAGS += -ffunction-sections -fdata-sections
LDFLAGS += -L$(STAGEDIR)/lib  -Wl,--gc-sections

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

configure:
	( cd $(SRC_NAME) ; \
	./configure --crossbuild=Linux::mips \
	--without-http_gzip_module \
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
