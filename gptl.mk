ifneq ($(GPTL), )
mpas.o			: private override FFLAGS += -I /glade/u/home/jdvanover/gptl-8.1.1/install-intel/include -DGPTL
LDFLAGS += -L /glade/u/home/jdvanover/gptl-8.1.1/install-intel/lib -lgptl -lgptlf -rdynamic

## entire
FFLAGS += -g -finstrument-functions
FFLAGS := $(filter-out -O3, $(FFLAGS))
FFLAGS += -O1
CPPFLAGS += -g -finstrument-functions
CPPFLAGS := $(filter-out -O3, $(CPPFLAGS))
CPPFLAGS += -O1

mpas.o			: private override FFLAGS := $(filter-out -finstrument-functions, $(FFLAGS))
endif