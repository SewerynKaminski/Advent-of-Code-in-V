module day6

struct A9{
	mut:
	d [9]u64
}

fn (mut t A9)next( day u64 ) {
	t.d[(day+7)%9] += t.d[day%9]
}

fn (mut t A9)total() u64 {
	return t.d[0]+t.d[1]+t.d[2]+t.d[3]+t.d[4]+t.d[5]+t.d[6]+t.d[7]+t.d[8]
}

fn (mut f A9)add ( a []int) {
	for i in a {
		f.d[i] += 1
	}	
}

fn new_fishes ( a []int ) A9 {
	mut f:=A9{}
	f.add( a )
	return f
}

fn f( a []int, days u64 ) u64{	
	mut fishes := new_fishes(a)
	for day in 0..days {
		fishes.next( day )
	}
	return fishes.total()
}

pub fn task1() string {
	t := [3,4,3,1,2]
	return f(t, 80 ).str()
}

pub fn task2() string { 
        t := [3,4,3,1,2]
        return f(t, 256 ).str()
}
