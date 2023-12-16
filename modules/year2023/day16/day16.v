module day16

import aoc
import term
import math

const path = 'modules/year2023/day16/input'

struct Beam{
   mut:
   x i64
   y i64
   dx i64
   dy i64
}

fn load() ![]string {
    return aoc.read_lines( path )!
}

fn energize( data []string, start Beam ) u64 {
   mut beams:=[start]
   w:= data[0].len
   h:= data.len
   mut visited:=[][]u8{len:h,init:[]u8{len:w, init: 0 }}

   for beams.len > 0 {
      mut b:= beams.pop()
      b.x += b.dx
      b.y += b.dy
      if b.x>=0 && b.x<w && b.y>=0 && b.y<h {
         if b.dx== 1 { if visited[b.y][b.x]&1==1{continue} visited[b.y][b.x] |= 1 }
         if b.dy== 1 { if visited[b.y][b.x]&2==2{continue} visited[b.y][b.x] |= 2 }
         if b.dx==-1 { if visited[b.y][b.x]&4==4{continue} visited[b.y][b.x] |= 4 }
         if b.dy==-1 { if visited[b.y][b.x]&8==8{continue} visited[b.y][b.x] |= 8 }
         
         match data[b.y][b.x]{
            `/` { 
                   if b.dx==1 || b.dx==-1 {
            	      b.dx, b.dy = b.dy, -b.dx 
            	   } else {
            	      b.dx, b.dy = -b.dy, b.dx 
            	   }
            	}
            `\\`{ 
                   if b.dx==1 || b.dx==-1 {
            	      b.dx,b.dy = b.dy, b.dx 
            	   } else {
            	      b.dx,b.dy = b.dy, b.dx 
            	   }
            	}
            `-` { 
            	   if b.dy==1 || b.dy==-1 { 
            	      b.dx, b.dy = -1, 0
            	      beams << Beam { b.x, b.y, 1, 0 }
            	   }
            	}
            `|` { 
            	   if b.dx==1 || b.dx==-1 { 
            	      b.dx, b.dy = 0,-1
            	      beams << Beam { b.x, b.y, 0, 1 }
            	   }
            	}
            else { }
         }
         beams << Beam { b.x, b.y, b.dx, b.dy }
      }
   }

   /*for l in visited {
      println ( l.map ( u8(u8(it>0)*(`#` - `.`) + `.`) ).bytestr() )
   }*/
   
   mut sum:= u64(0)
   for l in visited {
      for v in l {
         sum+= u64(v>0)
      }
   }

   return sum
}

pub fn task1() string {
   data:= load() or { return term.bright_red("[Error]Load:"+err.str()) }
     
   ans := energize ( data, Beam {-1, 0, 1, 0} )
   
   return ans.str()
}

pub fn task2() string { 
   data:= load() or { return term.bright_red("[Error]Load:"+err.str()) }
   w:= data[0].len
   h:= data.len
   
   mut ans:=u64(0)
   for v in 0..h {
      ans = math.max ( ans, energize ( data, Beam{-1, v, 1, 0} ) )
      ans = math.max ( ans, energize ( data, Beam{ w, v,-1, 0} ) )
   }
   for v in 0..w {
      ans = math.max ( ans, energize ( data, Beam{ v, -1, 0, 1} ) )
      ans = math.max ( ans, energize ( data, Beam{ v, h, 0,-1} ) )
   }
   
   return ans.str()
}

