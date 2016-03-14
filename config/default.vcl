vcl 4.0;

backend default {
        .host = "127.0.0.1";
        .port = "8080";
}

backend debian {
        .host = "64.50.236.52";
        .port = "80";
        .connect_timeout = 5s;
        .first_byte_timeout = 10s;
        .between_bytes_timeout = 10s;
}

backend ubuntu {
        // The IP below is one of the IPs for archive.ubuntu.com
        .host = "91.189.92.201";
        .port = "80";
        .connect_timeout = 5s;
        .first_byte_timeout = 10s;
        .between_bytes_timeout = 10s;
}

sub vcl_recv {
        if (req.url ~ "^/debian/.*") {
                set req.backend_hint = debian;
        } elsif (req.url ~ "^/ubuntu/.*") {
                set req.backend_hint = ubuntu;
        } else {
                set req.backend_hint = default;
        }
}

sub vcl_backend_response {
        if (bereq.url ~ "^/debian") {
                if (bereq.url ~ ".deb$") {
                        set beresp.ttl = 21d;
                } else {
                        set beresp.ttl = 12h;
                }
        } elsif (bereq.url ~ "^/ubuntu") {
                if (bereq.url ~ ".deb$") {
                        set beresp.ttl = 21d;
                } else {
                        set beresp.ttl = 12h;
                }
        } elsif (bereq.url ~ "^/slaughter") {
                set beresp.ttl = 1s;
        } elsif (bereq.url ~ "^/munin/") {
                set beresp.ttl = 30s;
        } else {
                set beresp.ttl = 10s;
                # set beresp.cacheable = false;
        }
}