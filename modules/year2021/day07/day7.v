module day07

import os
import math
import arrays

const path = 'modules/year2021/day7/input'

fn load ( file os.File ) []i64 {
    mut ret := []i64{}
    mut buf:= []u8{len:1024}
    mut t:= ""

    mut l := file.read_bytes_into_newline( mut buf ) or {0}
    for l>0 {
	t += buf[0..l].bytestr()
	l = file.read_bytes_into_newline( mut buf ) or {0}
    }
    for v in t.split(',').map( it.int() ) {
	ret << v
    }
    
    return ret
}

pub fn task1() string {
   mut ans := i64(0x7fffffffffffffff)
   mut file := os.open_file ( path, 'r' ) or {      
      return "[Error]open"
   }

   data := load ( file )
	
   mut imin := arrays.idx_min ( data )or{0}
   mut imax := arrays.idx_max ( data )or{0}
   if imin > imax {
      imin, imax = imax, imin
   }

   for i:=imin; i<imax; i++ {
       mut sum := i64(0)
       for v in data {
           sum += math.abs ( v - i )
       }
       ans = math.min ( ans, sum )
   }

   return ans.str()
}

pub fn task2() string { 
   mut ans := i64(0x7fffffffffffffff)

   mut file := os.open_file ( path, 'r' ) or {      
      return "[Error]open"
   }

   data := load ( file )

   mut imin := arrays.idx_min ( data )or{0}
   mut imax := arrays.idx_max ( data )or{0}
   if imin > imax {
      imin, imax = imax, imin
   }

   for i := imin; i < imax; i++ {
      mut sum := i64(0);
      for v in data {
         d := math.abs ( v - i )
         sum += d * ( d + 1 ) / 2
      }
      ans = math.min ( ans, sum )
   }

   return ans.str()
}

