module day24

import os
import term

const path = 'modules/year2021/day24/input'

fn load() ![]string {
   return os.read_lines( path )!
}

struct Ss{
   mut:i1 i8
   i2 i8
   v i8
}

fn analize( data []string ) []Ss {
   mut i:=u32(0)
   mut j:=i8(-1)
   mut a:=i8(0)
   mut b:=i8(0)
   mut d:=false
   mut t:=[]Ss{}
   mut pairs:=[]Ss{}
   for line in data{
      if line=="inp w"{
         i=0
	 j+=1
      }
      if i==4 {
         //print ( line )
	 d = line[line.len-1]==49
      }
      if i==5 {
         a = i8(line[6..].int())
         //print ( line )
      }
      if i==15 {
         b = i8(line[6..].int())
         //print ( line )
	 if d {
	    // add
            //print("${j},${b}\n");
	    t << Ss{j,0,b}
	 } else {
            //print("${j},${a}\n");
            mut s:= t[t.len-1]
	    s.i2 = j
            s.v += a
            //print( "${s}" )
	    pairs << s
	    t.delete(t.len-1)
	 }
      }
      i+=1
   }
   return pairs
}

pub fn task1() string {
   data := load() or { return term.bright_red("[Error]Load:"+err.str()) }
   pairs := analize ( data )
   mut max:=[]u8{len:14, init:48+9}
   for p in pairs {
   	if p.v<0 {
   	   max[p.i2] = u8(i8(max[p.i2]) + p.v)
   	} else {
   	   max[p.i1] = u8(i8(max[p.i1]) - p.v)
   	}
   }
   
   return max.bytestr()
}

pub fn task2() string { 
   data := load() or { return term.bright_red("[Error]Load:"+err.str()) }
   pairs := analize ( data )
   mut min:=[]u8{len:14, init:48+1}
   for p in pairs {
   	if p.v<0 {
   	   min[p.i1] = u8(i8(min[p.i2]) - p.v)
   	} else {
   	   min[p.i2] = u8(i8(min[p.i1]) + p.v)
   	}
   }
   
   return min.bytestr()
}

