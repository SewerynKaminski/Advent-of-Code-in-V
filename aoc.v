// v run .

import os
import term
import aoc
import math
import year2020
import year2021
import year2023

struct YD {
   y i32
   d aoc.Days
}

const years = [ YD{ y:year2020.year, d:year2020.days},
	        YD{ y:year2021.year, d:year2021.days},
		YD{ y:year2023.year, d:year2023.days}
          ]

fn ok(r i32, v i32 ) bool{
   return v==r || r==0
}


fn run_day ( days aoc.Days, di i32 ) {
   match di {
      1  {days.day_1.run()}
      2  {days.day_2.run()}
      3  {days.day_3.run()}
      4  {days.day_4.run()}
      5  {days.day_5.run()}
      6  {days.day_6.run()}
      7  {days.day_7.run()}
      8  {days.day_8.run()}
      9  {days.day_9.run()}
      10 {days.day_10.run()}
      11 {days.day_11.run()}
      12 {days.day_12.run()}
      13 {days.day_13.run()}
      14 {days.day_14.run()}
      15 {days.day_15.run()}
      16 {days.day_16.run()}
      17 {days.day_17.run()}
      18 {days.day_18.run()}
      19 {days.day_19.run()}
      20 {days.day_20.run()}
      21 {days.day_21.run()}
      22 {days.day_22.run()}
      23 {days.day_23.run()}
      24 {days.day_24.run()}
      25 {days.day_25.run()}
      else{days.run()}
   }
}

fn main() {
   mut y:=i32(0)
   mut days:=[]bool { len:25, init:false }

   for arg in os.args[1..] {
      if arg.contains('-') {
         s:=arg.split('-')
         from := math.max ( 1, math.min ( 25, s[0].u32() ) )
         to   := math.max ( 1, math.min ( 25, s[1].u32()  ) )
         for i in from..to+1 { days[i] = true }
      } else {
         match arg {
	   '1','2','3','4','5','6','7','8','9','10',
	   '11','12','13','14','15','16','17','18','19','20',
           '21','22','23','24','25' { days[i32(arg.int())]=true }
	   '2020','2021','2022','2023' { y=i32(arg.int()) }
	   'T','t' { }
	   else {
	      println ( 'Unknown argument $arg' )
	   }
         }
      }
   }

   for yd in years {
      if ok(y, yd.y) {
         println ( term.bright_yellow("Year ${yd.y}") )
         for d, r in days {
            if d>0 && r == true {
	       run_day ( yd.d, i32(d) )
	    }
	 }
	 if days.all( it==false ) {
	    run_day ( yd.d, 0 )
	 }
      }
   }

}
