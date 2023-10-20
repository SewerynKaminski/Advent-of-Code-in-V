// v run .

import os
import aoc
import year2020
import year2021

struct YD {
   y i32
   d aoc.Days
}

const years = [ YD{ y:year2020.year, d:year2020.days},
	        YD{ y:year2021.year, d:year2021.days}
          ]

fn ok(r i32, v i32 ) bool{
   return v==r || r==0
}

fn run_day ( days aoc.Days, d i32 ) {
   match d {
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
      24 {days.day_23.run()}
      25 {days.day_25.run()}
      else{days.run()}
   }
}

fn main() {
   mut y:=0
   mut d:=0

   for arg in os.args[1..] {
      match arg {
	'1','2','3','4','5','6','7','8','9','10',
	'11','12','13','14','15','16','17','18','19','20',
        '21','22','23','24','25'{d=arg.int()}
	'2020','2021'{y=arg.int()}
	else{ println('')}
      }
   }

   for yd in years {
      if ok(y, yd.y) { run_day ( yd.d, d ) }
   }

}
