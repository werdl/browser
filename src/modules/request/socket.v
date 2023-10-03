module request

import net.http

struct Response{
	body string
	header http.Header
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
	println(request_str)
	data := http.get(request_str) or {panic(err)}
    
	return Response{
		body: data.body
		header: data.header
	}
}
pub fn (r Response) print() {
	println("${r.body[0..100]}\n\n...\n\nHeaders:${r.header}")
}