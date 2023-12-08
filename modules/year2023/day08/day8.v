module day08

import os
import term 

const path='modules/year2023/day08/input'
           //'modules/year2023/day08/input_test'
           //'modules/year2023/day08/input_test2'

struct Ss {
mut:
   next []string
}

struct DATA{
mut:
   dir []u8
   m map[string] Ss
}

fn load() !DATA{
   mut data := DATA{}

   lines := os.read_lines( path )!
   data.dir = lines[0].bytes().map( u8(it==`R`) )
   for line in lines[2..] {
         s := line.fields()
         key  := s[0]
         left := s[2].substr_ni(1,-1)
         right:= s[3].substr_ni(0,-1)
         a:=[left,right]
         data.m[key] = Ss{next: a}
   }

   return data
}

pub fn task1() string {
   data:= load() or { return term.bright_red("[Error]open:"+err.str()) }

   l:= data.dir.len
   mut p:= 'AAA'
   mut i:=0
   for p!='ZZZ' {
      p = data.m[p].next[data.dir[i%l]]
      i+=1
   }
   return i.str()
}

// Lowest Common Multiple
fn lcm ( a u64, b u64 ) u64 {
   mut v1:=a
   mut v2:=b
   f:= fn(v u64, a u64) u64 {
      m := v % a
      if m > 0 { return v - m + a }
      else { return v }
   }
   for v1!=v2 {
      if v1>v2 {
	 v2 = f ( v1, b )
      } else { 
	 v1 = f ( v2, a )
      }
   }
   return v1
}

pub fn task2() string { 
   data := load() or { return term.bright_red("[Error]open:"+err.str()) }
   l:= u64(data.dir.len)
   mut p:= data.m.keys().filter( it.ends_with('A') )
   mut ans:=u64(1)

   for e in p {
      mut i:= u64(0)
      mut key:= e      
      for !key.ends_with('Z') {
         key = data.m[key].next[data.dir[i%l]]
         i+=1
      }
      ans = lcm ( ans, i )
   }

   return ans.str()
}
