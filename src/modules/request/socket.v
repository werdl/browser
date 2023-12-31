module request

import net.http

pub struct Response{
	pub:
		body string
		header http.Header
		code int
		msg string
		version string
}
fn (u URL) handle(request_str string) {
	println("${request_str} was met with an error. Ensure this is the right domain.")
}
pub fn (u URL) read() Response {
	mut request_str:= match u.port==0 {
		true {
			'${u.scheme}://${u.host}/${u.path}'
		} 
		false {
			'${u.scheme}://${u.host}:${u.port}/${u.path}'
		}
	}
	if u.scheme=="https" {
		request_str='${u.scheme}://${u.host}:443/${u.path}'
	}
	data := http.get(request_str) or { 
		u.handle(request_str)
		return Response{}
	}
    
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
pub fn (r Response) print_short() {
	if r.code!=0 {
		println("${r.code} - ${r.msg}")
	}
}