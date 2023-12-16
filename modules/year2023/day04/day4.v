module day04

import aoc
import term

const path = 'modules/year2023/day04/input'

struct Ss {
mut:
   win []int
   have []int
   v i64=1
}

fn (s Ss)clone() Ss {
   return Ss{win:s.win.clone(), have:s.have.clone(), v:s.v}
}

fn insert_sorted ( mut a []int, w int ) {
   mut j := a.len
   for i, v in a {
        if w < v {
            j = i
            break
        }
   }

   a.insert ( j, w )
}

fn load() ![]Ss {
   mut data := []Ss {}
   lines := aoc.read_lines( path )!
   for line in lines {
      mut card:=Ss{}
      s := line.split ( ':' )
      s2 := s[1].split ( ' | ' )
      for ws in s2[0].split ( ' ' ) { 
         if ws.len > 0 {
	    insert_sorted ( mut card.win, ws.int() )
	 }
      }
      for n in s2[1].split ( ' ' ) {
         if n.len>0 { card.have << n.int() }
      }
      data << card.clone()
   }
   
   return data
}

fn count_wins( card Ss ) int {
   mut cnt:=0
   for v in card.have {
      for w in card.win {
         if w>v { break }
         if w==v {
            cnt++
         }
      }
   }
   return cnt
}

pub fn task1() string {
   mut ans := i64(0)
   mut data := load() or { return term.bright_red("[Error]open:"+err.str()) }

   for card in data {
      cnt:= count_wins ( card )      
      if cnt > 0 {
         ans += 1<<(cnt-1)
      }
   }

   return ans.str()
}

pub fn task2() string { 
   mut ans := i64(0)
   mut data := load() or { return term.bright_red("[Error]open:"+err.str()) }

   for i,card in data {
      cnt:= count_wins( card )
      for j in i+1..i+1+cnt {
         data[j].v += card.v
      }
      ans += card.v
   }

   return ans.str()
}
