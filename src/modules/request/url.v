module request
import os
struct URL {
    scheme string
	host string
	path string
	port int
}
pub fn new(urlraw string) URL {
	mut scheme_v,mut hostpathport:=urlraw.split_once("://")
	if scheme_v=="" {
		hostpathport=urlraw
	}
	mut hostport,mut path_v:=hostpathport.split_once("/")
	if path_v=="" {
		hostport=hostpathport
	}
	mut host_v,mut port_v:=hostport.split_once(":")
	if host_v=="" {
		host_v=hostport
		port_v="0"
	}
	valid_schemes:=["http","https"]
	if scheme_v !in valid_schemes {
		if "--debug" in os.args {
			println("${scheme_v} is not recognised as a valid scheme. defaulting to http.")
		}
		
		scheme_v="http"
	}
	if path_v!="" {
		path_v="/"+path_v+"/"
	}
	
	return URL{
		scheme: scheme_v
		host: host_v
		path: path_v
		port: port_v.int()
	}
}