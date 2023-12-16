module day13

import aoc
import term

const path='modules/year2023/day13/input'

struct DATA{
mut:
   row []string
}

fn load() ![]DATA {
   mut pats:= []DATA{}
   mut data := aoc.read_lines( path )!
   mut p:= DATA{}
   for line in data {
      if line.len > 0 {
         p.row << line
      } else {
         pats << p
         p = DATA{}
      }
   }
   if p.row.len > 0 {pats << p}
   return pats
}

fn check_horizontal ( p DATA, v int ) i64 {
  mut diff:=0
  l := p.row.len
  for j in 0..l-1 {
      diff = 0
      for i:=1; i+j<l && j-i+1>=0; i++ {
         for c in 0..p.row[0].len {
            diff += int ( p.row[i+j][c]!=p.row[j-i+1][c] )
            //if p.row[i+j][c]!=p.row[j-i+1][c] { diff += 1 }
         }
      }
      if diff==v {
         return j+1
      }
   }
   return 0
}

fn check_vertical( p DATA, v int ) i64 {
  mut diff:=0
  l := p.row[0].len
  for j in 0..l-1 {
      diff=0
      for i:=1; i+j<l && j-i+1>=0; i++ {
         for r in 0..p.row.len {
            diff += int ( p.row[r][i+j]!=p.row[r][j-i+1] )
            //if p.row[r][i+j]!=p.row[r][j-i+1] { diff += 1 }
         }
      }
      if diff==v {
         return j+1
      }
   }
   return 0
}

pub fn task1() string {
   mut ans:=i64(0)
   data:= load() or { return term.bright_red("[Error]Load:"+err.str()) }

   for p in data { 
      ans += check_horizontal ( p, 0 ) * 100 +
             check_vertical ( p, 0 )
   }

   return ans.str()
}

pub fn task2() string { 
   mut ans:=i64(0)
   data:= load() or { return term.bright_red("[Error]Load:"+err.str()) }

   for p in data {
      ans += check_horizontal ( p, 1 ) * 100 +
             check_vertical ( p, 1 )
   }

   return ans.str()
}

