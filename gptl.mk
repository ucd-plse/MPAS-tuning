ifneq ($(GPTL), )

mpas_atm_time_integration.o 		: private override FFLAGS += -I /root/gptl-8.1.1/install/include -DGPTL
mpas_atm_core.o						: private override FFLAGS += -I /root/gptl-8.1.1/install/include -DGPTL
mpas_timer.o						: private override FFLAGS += -I /root/gptl-8.1.1/install/include -DGPTL
mpas_dmpar.o						: private override FFLAGS += -I /root/gptl-8.1.1/install/include -DGPTL
mpas_atm_iau.o						: private override FFLAGS += -I /root/gptl-8.1.1/install/include -DGPTL
mpas_log.o							: private override FFLAGS += -I /root/gptl-8.1.1/install/include -DGPTL
mpas_pool_routines.o				: private override FFLAGS += -I /root/gptl-8.1.1/install/include -DGPTL
mpas_atmphys_driver_microphysics.o	: private override FFLAGS += -I /root/gptl-8.1.1/install/include -DGPTL
mpas_atmphys_todynamics.o			: private override FFLAGS += -I /root/gptl-8.1.1/install/include -DGPTL
mpas_atm_boundaries.o				: private override FFLAGS += -I /root/gptl-8.1.1/install/include -DGPTL
mpas_timekeeping.o					: private override FFLAGS += -I /root/gptl-8.1.1/install/include -DGPTL
mpas_vector_reconstruction.o		: private override FFLAGS += -I /root/gptl-8.1.1/install/include -DGPTL
mpas.o	: private override FFLAGS += -I /root/gptl-8.1.1/install/include -DGPTL
LDFLAGS += -L /root/gptl-8.1.1/install/lib -lgptl -lgptlf -rdynamic

endif