module day15

//import aoc
import os
import term

const path='modules/year2023/day15/input'

fn load() ![]string {
   mut p := path
   //if aoc.test_mode() { p += '_test' }
   data := os.read_lines ( p )!
   return data[0].split(',')
}

fn hash ( s string) u8 {
   mut h := u8(0)
   for c in s {
      h=h+c
      h*=17
   }
   return h
}

pub fn task1() string {
   mut ans:=u64(0)
   data := load() or { return term.bright_red("[Error]Load:"+err.str()) }   
   for v in data {
      ans+= hash ( v )
   }

   return ans.str()
}

struct Lens{
   label string
   f u8
   add bool
}

fn (l Lens) box() u8 {
   return hash ( l.label )
}

fn (a Lens)==(b Lens) bool {
   return a.label==b.label
}

pub fn task2() string { 
   mut ans:=u64(0)
   mut boxes:=[][]Lens{len:256, init:[]Lens{}}

   data := load() or { return term.bright_red("[Error]Load:"+err.str()) }
   for v in data {
      mut lens:= Lens{}
      if v.ends_with('-') { 
         lens = Lens {
            label: v[0..v.len-1],
            add: false
	 }
      } else { 
         lens = Lens { 
            label: v[0..v.len-2],
            f: v[v.len-1]-48,
            add: true
         }
      }
      
      if lens.add {
         i:= boxes [ lens.box() ].index ( lens )
         if i < 0 {
            boxes [ lens.box() ] << lens
         } else {
            boxes [ lens.box() ][i] = lens
         }
      } else {
         if boxes [ lens.box() ].len > 0 {
            i:= boxes [ lens.box() ].index ( lens )
            if i >= 0 {
               boxes [ lens.box() ].delete ( i )
	    }
         }
      }
   }
   
   for i,box in boxes {
      for j,lens in box {
         ans += u64(i+1) * u64(j+1) * u64(lens.f)
      }
   }

   return ans.str()
}
