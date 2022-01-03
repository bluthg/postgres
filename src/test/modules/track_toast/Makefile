# src/test/modules/track_toast/Makefile

REGRESS = track_toast
REGRESS_OPTS = --temp-config=$(top_srcdir)/src/test/modules/track_toast/track_toast.conf
# Disabled because these tests require "track_toast = on",
# which typical installcheck users do not have (e.g. buildfarm clients).
NO_INSTALLCHECK = 1

ifdef USE_PGXS
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
else
subdir = src/test/modules/track_toast
top_builddir = ../../../..
include $(top_builddir)/src/Makefile.global
include $(top_srcdir)/contrib/contrib-global.mk
endif
