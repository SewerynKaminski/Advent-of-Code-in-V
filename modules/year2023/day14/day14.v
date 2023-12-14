module day14

import os
import term
import hash

const path='modules/year2023/day14/input'
           //'modules/year2023/day14/input_test'

fn load() ![][]u8 {
   mut data:= [][]u8{}
   mut lines := os.read_lines( path )!
   for line in lines {
      data << line.bytes()
   }
   return data
}

pub fn task1() string {
   mut ans:=i64(0)
   mut data:= load() or { return term.bright_red("[Error]Load:"+err.str()) }

   for col in 0..data[0].len {
      mut first_free := 0
      for row:=0; row<data.len; row++ {
         c := data[row][col]
         if c==`#` { first_free = row+1 }
         else if c==`O` {
            data[row][col] = `.`
            data[first_free][col] = `O`
            ans += data.len - first_free
            first_free += 1
         }
      }
   }

   return ans.str()
}

fn tilt_north ( mut data [][]u8 ) {
   for col in 0..data[0].len {
      mut first_free := 0
      for row:=0; row<data.len; row++ {
         c := data[row][col]
         if c==`#` { first_free = row+1 }
         else if c==`O` {
            data[row][col] = `.`
            data[first_free][col] = `O`
            first_free += 1
         }
      }
   }
}

fn tilt_south ( mut data [][]u8 ) {
   for col in 0..data[0].len {
      mut first_free := data.len-1
      for row:=data.len-1; row>=0; row-- {
         c := data[row][col]
         if c==`#` { first_free = row-1 }
         else if c==`O` {
            data[row][col] = `.`
            data[first_free][col] = `O`
            first_free -= 1
         }
      }
   }
}

fn tilt_west ( mut data [][]u8 ) {
   for row in 0..data.len {
      mut first_free := 0
      for col:=0; col<data[0].len; col++ {
         c := data[row][col]
         if c==`#` { first_free = col+1 }
         else if c==`O` {
            data[row][col] = `.`
            data[row][first_free] = `O`
            first_free += 1
         }
      }
   }
}

fn tilt_east ( mut data [][]u8 ) {
   for row in 0..data.len {
      mut first_free := data[0].len-1
      for col:=data[0].len-1; col>=0; col-- {
         c := data[row][col]
         if c==`#` { first_free = col-1 }
         else if c==`O` {
            data[row][col] = `.`
            data[row][first_free] = `O`
            first_free -= 1
         }
      }
   }
}

fn cycle( mut data [][]u8 ) {
   tilt_north( mut data )
   tilt_west( mut data )
   tilt_south( mut data )
   tilt_east( mut data )
}

fn sum( data [][]u8 ) u64 {
   mut h:=u64(0)
   for l in data {
      h = hash.sum64 ( l, h )
   }
   return h
}

pub fn task2() string {
   mut data:= load() or { return term.bright_red("[Error]Load:"+err.str()) }

   mut hm:=map[u64]u64{}
   mut a:= u64(0)
   mut b:= u64(0)
   mut c:= u64(0)
   for true {
      h := sum ( data )
      if h in hm {
         a = hm[h]
         b = c
         break
      }
      hm[h] = c
      cycle ( mut data )
      c += 1
   }

   r := (u64(1000000000)-a)%(b-a)
   data = load() or { return term.bright_red("[Error]Load:"+err.str()) }
   for _ in 0..a+r {
      cycle ( mut data )
   }

   mut ans:= i64(0)
   for row in 0..data.len {
      for v in data[row] {
         ans += (data.len - row) * i64(v==`O`)
      }
   }

   return ans.str()
}
