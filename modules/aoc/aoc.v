module aoc

import term
import time

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

struct Task{
   run fn()string=unsafe{nil}
}

struct St {
 pub:   
   //tsk fn()string=unsafe{nil}// nie dzial?
   tsk Task
 pub mut:
   fin bool
}

fn(shared v St) run() string {
   mut ans:=''
   //mut f := fn()string{return''}
   lock v {
      //ans = v.day.task() // TODO:dlaczego dziala?!
      ans = v.tsk.run() // TODO:dlaczego nie dziala?!
      v.fin = true
   }
   return ans
}

const spiner_chars=['|','/','-','\\']
fn spiner( i u8 ) {
   //c := term.get_cursor_position() or {term.Coord{x:0,y:0}}
   //term.set_cursor_position( x:c.x, y:c.y ) 
   print( spiner_chars[i&3] )
   //print( '\n\b\e[A' )//\eM
   print( '\n\e[A' )
   //term.set_cursor_position( c )
}

fn spin ( txt string, tsk fn()string ) string {
   shared v:= unsafe{St{Task{tsk}, false}}
   mut h := spawn v.run()

   mut t:=0
   mut st:=u8(0)

   for !v.fin {
        t+=1
	if t>10 {
	   print(txt) spiner ( st )
	   st+=1
           t=0
	}
	time.sleep ( 10*time.millisecond )
   }
   ans := h.wait()
   print ( txt ) println ( ans )
   return ans
}

pub fn(day Day) run() {
   print ( "\e[?25l" ) // hide cursor
   println ( term.bright_green("  Day ${day.day}") )
   spin ( term.green("    Task 1: "), day.task_1 )
   spin ( term.green("    Task 2: "), day.task_2 )
   print ( "\e[?25h" ) // show cursor
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
