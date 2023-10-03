module request

import net.http

struct Response{
	body string
	header http.Header
	code int
	msg string
	version string
}
pub fn (u URL) read() Response {
	request_str:= match u.port==0 {
		true {
			'${u.scheme}://${u.host}/${u.path}'
		} 
		false {
			'${u.scheme}://${u.host}:${u.port}/${u.path}'
		}
	}
	data := http.get(request_str) or {panic(err)}
    
	return Response{
		body: data.body
		header: data.header
		code: data.status_code
		msg: data.status_msg
		version: data.http_version
	}
}
pub fn (r Response) print() {
	first_n:=r.body.split("\n")
	mut max:=6
	if first_n.len<max {
		max=first_n.len
	}
	println("${r.code} - ${r.msg} from server ${r.version}\n${first_n[0..max].join_lines()}\n\n...\n\nHeaders:${r.header}")
}
pub fn (r Response) show() {
	mut in_angle:=false
	for c in r.body {
		if r.body[c]=="<" {
			in_angle=true
		} else if (r.body[c])==">" {
			in_angle=false
		} else if !in_angle {
			print(r.body[c])
		}
	}
}