SRC_NAME=nginx-1.9.5

CFLAGS  += -ffunction-sections -fdata-sections
CXXFLAGS += -ffunction-sections -fdata-sections
LDFLAGS += -L$(STAGEDIR)/lib  -Wl,--gc-sections
#CROSS_PREFIX=mipsel-linux-uclibc-

THISDIR = $(shell pwd)

all: config_test
	$(MAKE) NGX_HTTP_UPSTREAM_ZONE=0  NGX_HAVE_ATOMIC_OPS=0 -C $(SRC_NAME)

config_test:
	( if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
		make configure && touch config_done; \
	fi )

#/opt/rt-n56u/toolchain-mipsel/toolchain-3.4.x/bin/mipsel-linux-uclibc-gcc
#/opt/rt-n56u/toolchain-mipsel/toolchain-3.4.x/bin/mipsel-linux-uclibc-gcc

#--without-http_gzip_module \
#--with-cc=/opt/rt-n56u/toolchain-mipsel/toolchain-3.4.x/bin/mipsel-linux-uclibc-gcc \
configure:
	( cd $(SRC_NAME) ; \
	./configure --crossbuild=Linux::mips \
	--with-zlib=$(STAGEDIR) \
	--without-http_rewrite_module ; \
	)


clean:
	if [ -f $(SRC_NAME)/Makefile ] ; then \
		$(MAKE) -C $(SRC_NAME) distclean ; \
	fi ; \
	rm -f config_done
	rm -rf install

romfs:
	$(ROMFSINST) $(THISDIR)/$(SRC_NAME)/src/nginx /usr/sbin/xsnginx
	$(ROMFSINST) -p +x /usr/sbin/nginx
