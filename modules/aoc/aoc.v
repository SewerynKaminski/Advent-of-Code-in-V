module aoc

//pub struct Year{
//	pub:
//	y u16
//	days Days
//}

//pub fn(y Year) year() u16 {
//	return y.y
//}

//pub fn(y Year) run() {
//  println ( "AoC ${y.year()}" )  
//  y.days.run()
//}

pub const days=Days{}

pub struct Day {
	pub:
	day u8
	task_1 fn()string = unsafe{nil}
	task_2 fn()string = unsafe{nil}
}

pub fn(t Day) run() {
	println ( "  Day ${t.day}" )
	println ( "    Task 1: ${t.task_1()}" )
	println ( "    Task 2: ${t.task_2()}" )
}

pub struct Days{
	pub:
	day_1  Day
	day_2  Day
	day_3  Day
	day_4  Day
	day_5  Day
	day_6  Day
	day_7  Day
	day_8  Day
	day_9  Day
	day_10 Day
	day_11 Day
	day_12 Day
	day_13 Day
	day_14 Day
	day_15 Day
	day_16 Day
	day_17 Day
	day_18 Day
	day_19 Day
	day_20 Day
	day_21 Day
	day_22 Day
	day_23 Day
	day_24 Day
	day_25 Day	
}

pub fn(d Days) run() {
	d.day_1.run()
	d.day_2.run()
	d.day_3.run()
	d.day_4.run()
	d.day_5.run()
	d.day_6.run()
	d.day_7.run()
	d.day_8.run()
	d.day_9.run()
	d.day_10.run()
	d.day_11.run()
	d.day_12.run()
	d.day_13.run()
	d.day_14.run()
	d.day_15.run()
	d.day_16.run()
	d.day_17.run()
	d.day_18.run()
	d.day_19.run()
	d.day_20.run()
	d.day_21.run()
	d.day_22.run()
	d.day_23.run()
	d.day_24.run()
	d.day_25.run()
}
