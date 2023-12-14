module day12

import os
import term

const path='modules/year2023/day12/input'
           //'modules/year2023/day12/input_test'

struct DATA {
  mut:
   pattern []u8
   damaged []u8
}

fn load() ![]DATA{
   mut data:= []DATA{}
   mut lines := os.read_lines( path )!
   for line in lines {
      s:= line.split(' ')
      data << DATA { 
		s[0].bytes(),
		s[1].split(',').map( it.u8() )
		}
   }
   return data
}

fn check( t []u8, p []u8 ) bool {
   for i in 0..t.len {
      if p[i]==`?`{ continue }
      if p[i]!=t[i]{ return false}
   }
   return true
}

fn prepare( d DATA ) i64 {
   mut sum := i64(0)
   plen := d.pattern.len
   mut t:= []u8{}
   mut m:= []u8{len:d.damaged.len, init:0}
   mut dlen := u8(0)
   for i in d.damaged { dlen+=i }

   mut done:=false
   for !done {
      t = []u8{}
      for i,len in d.damaged {
         for _ in 0..m[i] { t << `.` }
         for _ in 0..len { t << `#` }
         if t.len < plen { t << `.` }
      }
      for t.len < plen { t << `.` }

      if check ( t, d.pattern ) { sum+=1 }
      for i in 1..m.len+2 {
         if i==m.len+1 { done=true break}
         m[m.len-i]++
         mut max:= plen - dlen - d.damaged.len+1
         for j in 0..m.len-i { max -= m[j] }
         if m[m.len-i] <= max {
            break
         }
         m[m.len-i]=0
      }
   }
   return sum
}

pub fn task1() string {
   mut ans:= i64(0)
   data:= load() or { return term.bright_red("[Error]open:"+err.str()) }
   for row in data {    
      ans += prepare ( row )
   }
   return ans.str()
}

fn prepare2( d DATA ) u64 {
   mut sum := u64(0)
   plen := d.pattern.len
   mut t:= []u8{}
   mut m:= []u16{len:d.damaged.len, init:0}
   mut dlen := u16(0)
   for i in d.damaged { dlen+=i }

   mut done:=false
   for !done {
      t = []u8{}
      for i,len in d.damaged {
         for _ in 0..m[i] { t << `.` }
         for _ in 0..len { t << `#` }
         if t.len < plen { t << `.` }
      }
      for t.len < plen { t << `.` }
      //println ( m )
      if check ( t, d.pattern ) { sum+=1 }
      for i in 1..m.len+2 {
         if i==m.len+1 { done=true break}
         m[m.len-i]++
         mut max:= plen - dlen - d.damaged.len+1
         for j in 0..m.len-i { max -= m[j] }
         if m[m.len-i] <= max {
            break
         }
         m[m.len-i]=0
      }
   }
   return sum
}

// 11872298252194 too low
// 11863964946257 too low
pub fn task2() string { 
   mut ans:= u64(0)
   mut data:= load() or { return term.bright_red("[Error]open:"+err.str()) }

   mut sums1 := []u64{}
   for row in data {
      sums1 << prepare2 ( row )
   }
   
   for mut row in data {
      mut new_pattern := []u8{}
      new_pattern << row.pattern  new_pattern << `?`
      new_pattern << row.pattern
      row.pattern = new_pattern

      mut new_damaged := []u8{}
      new_damaged << row.damaged
      new_damaged << row.damaged
      row.damaged = new_damaged
   }

   mut sums2 := []u64{}
   for row in data {
      sums2 << prepare2 ( row )
   }
   
   for i,sum1 in sums1 {
      s := sums2[i]/sum1
      ans += sums2[i] * s * s * s
   }
   
   return ans.str()
}
/*
1  -> 1*1^4 = 1
32 -> 4*8^4 = 16384
1  -> 1*1^4 = 1
2  -> 1*2^4 = 16
20 -> 4*5^4 = 250
150->10*15^4= 506250

????.######..#####. 1,6,5, 1,6,5
#....######..#####.
.#...######..#####.
..#..######..#####.
...#.######..#####.

????.######..#####. ? ????.######..#####.
#....######..#####.#.....######..#####.
#....######..#####..#....######..#####.
#....######..#####...#...######..#####.
#....######..#####....#..######..#####.
#....######..#####.....#.######..#####.
.#...######..#####.
..#..######..#####.
...#.######..#####.
4*5=20
*/





















