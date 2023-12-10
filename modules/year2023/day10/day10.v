module day10

import os
import term

const path='modules/year2023/day10/input'
           //'modules/year2023/day10/input_test'
           //'modules/year2023/day10/input_test2'

struct Point{
mut:
   x int
   y int
}

fn load() ![]string{
   mut data := os.read_lines( path )!
   len := data[0].len+2
   data = data.map( "."+it+"." )
   data.insert( 0, ".".repeat(len) )
   data << ".".repeat(len)
   
   return data
}

fn right ( d []string, p Point ) ?Point {
   if d[p.y].substr(p.x+1,p.x+2).index_any('-J7') == 0 {
      return Point{p.x+1,p.y}
   }
   return none
}

fn left ( d []string, p Point ) ?Point {
   if d[p.y].substr(p.x-1,p.x).index_any('-FL') == 0 {
      return Point{p.x-1,p.y}
   }
   return none
}

fn up ( d []string, p Point ) ?Point {
   if d[p.y-1].substr(p.x,p.x+1).index_any('|7F') == 0 {
      return Point{p.x,p.y-1}
   }
   return none
}

fn down ( d []string, p Point ) ?Point {
   if d[p.y+1].substr(p.x,p.x+1).index_any('|JL') == 0 {
      return Point{p.x,p.y+1}
   }
   return none
}

fn next(d []string, p Point ) []Point {
   mut ret:=[]Point{}
   c:= d[p.y].substr( p.x, p.x+1 ) 
   if c.index_any('-J7') == 0 {
      if r := left ( d, p )  { ret << r }
   }
   if c.index_any('-FL') == 0 {
      if r := right ( d, p ) { ret << r }
   }
   if c.index_any('|JL') == 0 {
      if r:= up ( d, p )     { ret << r }
   }
   if c.index_any('|7F') == 0 {
      if r:= down ( d, p )   { ret << r }
   }
   return ret
}

pub fn task1() string {
   mut ans := i64(2)
   data := load() or { return term.bright_red("[Error]open:"+err.str()) }
   mut sp:= Point{}
   for y in 0..data.len {
      for x in 0..data[y].len {
         if data[y][x]==`S` {
            sp = Point{x:x, y:y}            
         }
      }
   }

   mut ps:= []Point{}
   if r:= up( data, sp )   { ps << r }
   if r:= down( data, sp ) { ps << r }
   if r:= left( data, sp ) { ps << r }
   if r:= right( data, sp ){ ps << r }

   mut p:= ps[0]
   e:= ps[1]
   mut op:= sp
   for p!=e {
      ps = next( data, p )
      if ps[0]!=op { op = p p = ps[0] } else { op = p p = ps[1] }
      ans += 1
   }
   ans/=2
   return ans.str()
}

pub fn task2() string { 
   mut ans := i64(0)
   mut data := load() or { return term.bright_red("[Error]open:"+err.str()) }
   mut sp:= Point{}
   for y in 0..data.len {
      for x in 0..data[y].len {
         if data[y][x]==`S` {
            sp = Point{x:x, y:y}
         }
      }
   }

   mut b:=0
   if _:=right(data,sp){ b |= 2 }
   if _:=left(data,sp) { b |= 8 }
   if _:=up(data,sp)   { b |= 1 }
   if _:=down(data,sp) { b |= 4 }
   if b==0b0011{ data[sp.y]=data[sp.y].replace('S','L') }
   if b==0b0101{ data[sp.y]=data[sp.y].replace('S','|') }
   if b==0b0110{ data[sp.y]=data[sp.y].replace('S','F') }
   if b==0b1001{ data[sp.y]=data[sp.y].replace('S','J') }
   if b==0b1010{ data[sp.y]=data[sp.y].replace('S','-') }
   if b==0b1100{ data[sp.y]=data[sp.y].replace('S','7') }
  
   mut loop := []Point{}
   loop << sp
   mut ps:= []Point{}
   if r:= up( data, sp ) { ps << r }
   if r:= down( data, sp ) { ps << r }
   if r:= left( data, sp ) { ps << r }
   if r:= right( data, sp ){ ps << r }

   mut p:= ps[0]
   loop << p
   e:= ps[1]
   mut op:= sp
   for p!=e {
      ps = next( data, p )
      p = if ps[0]!=op { op = p ps[0] } else { op = p ps[1] }
      loop << p
   }

   for y in 1..data.len-1 {
      mut out := true
      mut last_c := u8(0)
      for x in 1..data[0].len-1 { 
         if Point{x,y} in loop {
            if data[y][x] != `-` {
               if ( data[y][x] == `|` ) ||
                  ( last_c==`F` && data[y][x]==`J` ) ||
                  ( last_c==`L` && data[y][x]==`7` ) {
                  out = !out
               }
               last_c = data[y][x]
            }
         } else if !out {
            ans += 1
         }
      }
   }

   return ans.str()

}

