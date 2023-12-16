module day09

import aoc
import term

const path='modules/year2023/day09/input'
           //'modules/year2023/day09/input_test'

struct DATA{
mut:
   reports [][]i64
}

fn load() !DATA{
   mut data := DATA{}

   lines := aoc.read_lines( path )!
   for line in lines {	 
         vals := line.fields().map( it.i64() )
         data.reports << vals
   }

   return data
}

pub fn task1() string {
   mut ans := i64(0)
   data := load() or { return term.bright_red("[Error]open:"+err.str()) }
   
   for report in data.reports {
      mut o := report.clone()
      mut n := []i64{}
      mut sum := i64(0)
      for !o.all( it == 0 ) {
         sum+= o.last()
         for i in 0..o.len-1 {
            n << o[i+1] - o[i]
         }
         unsafe{
           o=n
           n.clear()
         }
      }
      ans += sum
   }

   return ans.str()
}

pub fn task2() string { 
   mut ans := i64(0)
   data := load() or { return term.bright_red("[Error]open:"+err.str()) }

   for report in data.reports {
      mut o := report.clone()
      mut n := []i64{}
      mut sum := []i64{}
      for !o.all( it == 0 ) {
         sum << o.first()
         for i in 0..o.len-1 {
            n << o[i+1] - o[i]
         }
         unsafe{
           o=n
           n.clear()
         }
      }
      mut b := i64(0)
      for sum.len>0 {
         b = sum.pop() - b
      }
      ans += b
   }

   return ans.str()
}
