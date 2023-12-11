module day11

import os
import term
import math

const path='modules/year2023/day11/input'
           //'modules/year2023/day11/input_test'

struct Point{
mut:
   x i64
   y i64
}

fn(p Point)-(a Point) Point{
   return Point{x:p.x-a.x, y:p.y-a.y}
}

fn load() ![]Point{
   mut points:= []Point{}
   mut data := os.read_lines( path )!
   for y,line in data {
      for x,c in line {
         if c==`#` {
            points << Point{x:x,y:y}
         }
      }
   }
   return points
}

fn sum_paths_lengths( points []Point ) i64 {
   mut ans:= i64(0)
   for i,p1 in points[0..points.len-1] {
      for p2 in points[i+1..] {
         ans += math.abs(p1.x-p2.x) + math.abs(p1.y-p2.y)
      }
   }
   return ans
}

fn expand ( mut points []Point, times i64, f fn(mut p Point, d Point) ) {
   mut lp:= points[0]
   mut dd:= Point{}
   for mut p in points[1..] {
      d := p - lp
      if d.x > 1 { dd.x+= (d.x-1)*(times-1)}
      if d.y > 1 { dd.y+= (d.y-1)*(times-1)}
      lp = *p
      f ( mut p, dd )
   }
}

pub fn task1() string {
   mut points := load() or { return term.bright_red("[Error]open:"+err.str()) }

   points.sort( a.x < b.x )
   expand ( mut points, 2, fn(mut p Point,d Point){ p.x+=d.x})
   points.sort( a.y < b.y )
   expand ( mut points, 2, fn(mut p Point,d Point){ p.y+=d.y})
   ans := sum_paths_lengths( points )

   return ans.str()
}

pub fn task2() string { 
   mut points := load() or { return term.bright_red("[Error]open:"+err.str()) }

   points.sort( a.x < b.x )
   expand ( mut points, 1000000, fn(mut p Point,d Point){ p.x+=d.x})

   points.sort( a.y < b.y )
   expand ( mut points, 1000000, fn(mut p Point,d Point){ p.y+=d.y})

   ans := sum_paths_lengths ( points )

   return ans.str()
}
