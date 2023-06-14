rose-clean:
	# remove rose generated files
	rm -rf prose_logs prose_workspace *postprocessed* *.rmod rose_*

reset: rose-clean
	cd ../../src && git clean -i . && git checkout .