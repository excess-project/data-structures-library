# Makefile for the EXCESS data structures library.

# Configuration

# Install prefix
PREFIX = /opt/EXCESS

# This is a source/header file file library so install is the only task.
install:
	cp -r src/include $(PREFIX)/

# Example Makefile settings for using the EXCESS data structures library below.
# In particular the USE_<dependency> macros must be set for these options to
# be available.

# Data-structure libraries
NOBLEDIR = /opt/NOBLE/stable
NOBLELIB = $(NOBLEDIR)/lib/Linux64_x86/libNOBLE64.a

TBBDIR = /opt/IntelTBB/tbb
TBBLIB = -Wl,-rpath,$(TBBDIR)/build/linux_intel64_gcc_cc4.6_libc2.15_kernel3.13.0_release -L$(TBBDIR)/build/linux_intel64_gcc_cc4.6_libc2.15_kernel3.13.0_release/ -ltbb

# Search tree implementations from
#  UIT for EXCESS
#ETLDIR = /opt/EXCESS/EXCESSTreeLibrary
#ETLLIB = $(ETLDIR)/lib/libcbtree.a
#ETLLIB = $(ETLDIR)/lib/libdeltatree.a
#ETLLIB = $(ETLDIR)/lib/libgreenbst.a

# Hash map implementations from
#  [Nhan Nguyen and Philippas Tsigas, "Lock-free Cuckoo Hashing".
#   In the Proceedings of the 34th International Conference on Distributed
#   Computing Systems (ICDCS 2014), pages 627 - 636, IEEE press 2014].
#CCKHT = /opt/MiscDS/CCKHashtable
#CCKHTLIB = $(CCKHT)/libCCKHashtable.a

# Hash map implementations from
#  [Herlihy, M., Shavit, N. and M. Tzafrir, "Hopscotch Hashing".
#   In the Proc. of the 22nd International Symposium on Distributed Computing
#   (DISC 2008), pp. 350-364, 2008].
#HSHT = /opt/MiscDS/HSHashtable
#HSHTLIB = $(HSHT)/libHSHashtable.a

# General library configuration
#DSLIBFLAGS += -DUSE_NOBLE
#DSLIBFLAGS += -DUSE_TBB
#DSLIBFLAGS += -DUSE_ETL -DUSE_ETL_DELTATREE
#DSLIBFLAGS += -DUSE_CCKHT
#DSLIBFLAGS += -DUSE_HSHT

# Compiler settings
CFLAGS = -DLINUX64_X86 -O2 -fpermissive -march=native -DNDEBUG
CFLAGS += -I$(NOBLEDIR)/Include/ -I$(NOBLEDIR)/Src/
CFLAGS += -I$(TBBDIR)/include
CFLAGS += -I$(ETLDIR)/include
CFLAGS += -I$(CCKHT)
CFLAGS += -I$(HSHT) -I$(HSHT)/data_structures

LDFLAGS = $(NOBLELIB) $(TBBLIB) -lrt
LDFLAGS += $(ETLLIB)
LDFLAGS += $(CCKHTLIB)
LDFLAGS += $(HSHTLIB)

export

# Makefile

all:
#	# Nothing to do. This is a header file library.
#	cd src; $(MAKE) all

clean:
#	# Nothing to do. This is a header file library.
#	cd src; $(MAKE) clean
#	@rm 
