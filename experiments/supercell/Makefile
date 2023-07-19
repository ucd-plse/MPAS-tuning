clean:
	rm -f history*nc diag*nc history*nc log.*.err restart*nc restart_timestamp stdout.txt stderr.txt

rose-clean: clean
	# remove rose generated files
	rm -rf prose_logs prose_workspace *postprocessed* *.rmod rose_*

reset: rose-clean
	cd ../../src && git clean -i . && git checkout .