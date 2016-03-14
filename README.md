Ubercache
=========

I wanted to fiddle with Varnish a little bit and I thought a useful thing to try
might be creating a unified caching frontend for Debian, Ubuntu and possible
things like PyPi.

I was inspired by the following blog post:

https://kly.no/posts/2010_04_19__Caching_a_Debian_repository_with_Varnish__.html

I don't think this works yet at this point, but the Vagrant file works and the
varnish config file is syntactically correct and debian/ubuntu backends appear
to work, but I haven't tried actually using it with apt-cache.

I just wanted to get this up on github so I didn't completely lose the work and
maybe someone will pick it up or remind me about it some day.