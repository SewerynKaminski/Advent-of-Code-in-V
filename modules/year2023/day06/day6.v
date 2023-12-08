module day06

import os
import term
//import arrays
import math

const path='modules/year2023/day06/input'
	   //'modules/year2023/day06/input_test'

struct DATA{
mut:
   time i64
   distance i64
}

fn load ( ) ![]DATA {
   mut data := []DATA {}
   //mut line := []u8{len:1024}
   //mut file := os.open_file ( path, 'r' )!
   lines:= os.read_lines( path )!
   //mut l := file.read_bytes_into_newline ( mut line ) or {0}-1
   //mut s := line[0..l].bytestr().split ( ':' )
   mut s := lines[0].split ( ':' )
   times :=s[1].split( ' ' ).filter ( it.len>0 )
   timesi := times.map( it.i64() )

   //l = file.read_bytes_into_newline( mut line ) or {0}-1   
   //s = line[0..l].bytestr().split ( ':' )
   s = lines[1].split ( ':' )
   distances := s[1].split( ' ' ).filter ( it.len>0 )
   distancesi := distances.map( it.i64() )
   
   for i,t in timesi {
      data << DATA{time:t, distance:distancesi[i]}
   }

   //file.close()
   return data
}

pub fn task1() string {
   mut ans := i64(1)
   data:= load() or { return term.bright_red("[Error]open:"+err.str()) }

   for race in data {
      b := race.time
      c := race.distance
      d := b*b - 4*c
      t1:= i64 ( math.floor ( (b-math.sqrt(d)) / 2 ) ) + 1
      t2:= i64 ( math.ceil ( (b+math.sqrt(d)) / 2 ) ) - 1
      ans *= t2-t1+1
   }

   return ans.str()
}

pub fn task2() string { 
   data:= load() or { return term.bright_red("[Error]open:"+err.str()) }

   mut bs:=""
   mut cs:=""
   for r in data {
      bs += r.time.str()
      cs += r.distance.str()
   }

   b := bs.f64()
   c := cs.f64()
   d := b*b - 4*c
   t1:= math.floor ( (b-math.sqrt(d)) / 2 )
   t2:= math.ceil ( (b+math.sqrt(d)) / 2 ) - 1
   ans := t2-t1
   // float to i64 nie dziala, dlaczego? tcc!
   //print( t2-t1 )
   mut s:=""
   $if tinyc {
    s = ans.str().replace('.','')
    s = s[0..s.last_index('e+')or{s.len}]
   } $else {
      s = i64(ans).str()
   }
   return s
}
