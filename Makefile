run:
	bundle exec jekyll serve
build:
	bundle exec jekyll build
clean:
	rm -rf _site
	rm -rf .jekyll-cache
	rm -rf Gemfile.lock
