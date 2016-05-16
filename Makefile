README.html html: README.md local.tmpl.html
	pandoc -f markdown \
		--template local.tmpl.html README.md -o README.html

liverender:
	fswatch -l 0.1 -0 *.{md,tmpl.*} | xargs -0 -n1 -I{} make html

livereload:
	livereloadx -p 10002 --static .
