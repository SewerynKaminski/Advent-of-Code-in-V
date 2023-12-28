module day24

import aoc
import term

const path='modules/year2023/day24/input'

struct Point{x f64 y f64 z f64}
struct Hail {p Point v Point}

fn load() ![]Hail {
   lines := aoc.read_lines ( path )!
   mut data:= []Hail { }
   for line in lines {
      s:= line.split(' @ ')
      p:= s[0].split(', ')
      v:= s[1].split(', ')
      data << Hail{
         Point { p[0].trim_space().f64(), p[1].trim_space().f64(), p[2].trim_space().f64() },
         Point { v[0].trim_space().f64(), v[1].trim_space().f64(), v[2].trim_space().f64() } }
   }
   return data
}

pub fn task1() string { 
   mut ans:=i64(0)
   hails:= load() or { return term.bright_red("[Error]Load:"+err.str()) } 

   for i,h1 in hails {
      for j:=i+1; j<hails.len; j++ {
         h2:= hails[j]
         // x vy/vx - y + b = 0
         // vy * x - vx * y + b*vx = 0
         //  A * x +  B * y + C = 0
         // a1*b2-a2*b1=0 rownoleglosc
         a1:= h1.v.y
         b1:= -h1.v.x
         a2:= h2.v.y
         b2:= -h2.v.x
     	 w:= a1 * b2 - b1 * a2
	 if w != 0 { // badamy tylko proste nierownolegle
	    // A1*x + B1*y + C1 = 0
	    // A2*x + B2*y + C2 = 0
	    c1:= a1 * h1.p.x + b1 * h1.p.y
	    c2:= a2 * h2.p.x + b2 * h2.p.y

	    x:= f64 ( c1 * b2 - b1 * c2 ) / w
	    y:= f64 ( a1 * c2 - c1 * a2 ) / w

            if (!aoc.test_mode() && x >= f64(200000000000000) && x <= f64(400000000000000)
                                 && y >= f64(200000000000000) && y <= f64(400000000000000))
              || (aoc.test_mode() && x >= f64(7) && x <= f64(27)
                                  && y >= f64(7) && y <= f64(27) ) {
               if  //((h1.v.x>0 && h1.p.x<x) || (h1.v.x<0 && h1.p.x>x)) &&
                   //((h1.v.y>0 && h1.p.y<y) || (h1.v.y<0 && h1.p.y>y)) &&
                   //((h2.v.x>0 && h2.p.x<x) || (h2.v.x<0 && h2.p.x>x)) &&
                   //((h2.v.y>0 && h2.p.y<y) || (h2.v.y<0 && h2.p.y>y))
                   (h1.v.x * (x-h1.p.x))>=0 &&
                   (h1.v.y * (y-h1.p.y))>=0 &&
                   (h2.v.x * (x-h2.p.x))>=0 &&
                   (h2.v.y * (y-h2.p.y))>=0
               {
                  ans += 1
               } else {
               }
            } else {
            }
	 } else {
	 }
      }
   }
   return ans.str()
}

pub fn task2() string {
        return "?"
}

