module day05

import os
import term

const path = 'modules/year2021/day05/input'

struct Point{
mut:
   x i32
   y i32
}
struct Line {
mut:
   p1 Point 
   p2 Point 
}

fn h ( p Point ) u64 {
   return u64(p.x) | (u64(p.y)<<32)
}

fn ( p Point ) + ( o Point ) Point {
   return Point{x:p.x+o.x, y:p.y+o.y}
}

fn ( p Point ) == ( o Point ) bool {
   return p.x==o.x && p.y==o.y
}

fn load ( file os.File ) []Line {
    mut ret := []Line{}
    mut buf:= []u8{len:64}

    mut l := file.read_bytes_into_newline( mut buf ) or {0}-1 ;
    for l>0 {
	t := buf[0..l].bytestr().split ( ' -> ' )
	s1 := t[0].split ( ',' )
	s2 := t[1].split ( ',' )
	p1 := Point { x: i32(s1[0].int()), y: i32(s1[1].int()) }
	p2 := Point { x: i32(s2[0].int()), y: i32(s2[1].int()) }
	ret << Line{p1:p1, p2:p2}

	l = file.read_bytes_into_newline( mut buf ) or {0}-1 
    }

    return ret
}

//---------------------------------------------------------------------------//
fn is_vertical ( line Line ) bool {
    return line.p1.y == line.p2.y
}

//---------------------------------------------------------------------------//
fn is_horizontal ( line Line ) bool {
    return line.p1.x == line.p2.x
}

//---------------------------------------------------------------------------//
fn is_vertical_or_horizontal ( line Line ) bool {
    return is_horizontal ( line ) || is_vertical ( line )
}

pub fn task1() string {
    //file = aoc::is_test_enabled() ? test_input() : puzzle_input;
    mut file := os.open_file ( path, 'r' ) or {	return term.bright_red("[Error]open:"+err.str())}

    data := load ( file )
    //std::unordered_map<Point, int, Hash_Point> hash;
    mut hash := map[u64]i32{}

    for line in data {
        if is_vertical_or_horizontal ( line ) {
            //std::cout << line.p1 << "\n";
            mut d := Point{ line.p2.x - line.p1.x, line.p2.y - line.p1.y };
            d.x = i32(d.x>0)-i32(d.x<0)
	    d.y = i32(d.y>0)-i32(d.y<0)
            for p := line.p1; p != line.p2; p += d {
                //std::cout << p << "\n";
                hash[h(p)]+=1;
            }
            //std::cout << line.p2 << "\n";
            hash[h(line.p2)]+=1
        }
    }

    mut ans := 0
    for _,v in hash {
        ans += u8(v > 1)
    }

    return ans.str()
}

pub fn task2() string { 
   //auto& file = aoc::is_test_enabled() ? test_input() : puzzle_input;
   mut file := os.open_file ( path, 'r' ) or { return term.bright_red("[Error]open:"+err.str())}

   data := load ( file )
   mut hash := map[u64]i32{}

   for line in data {
      mut d := Point{ line.p2.x - line.p1.x, line.p2.y - line.p1.y }
      d.x = i32(d.x>0)-i32(d.x<0)
      d.y = i32(d.y>0)-i32(d.y<0)
      for p := line.p1; p != line.p2; p += d {
         hash[h(p)]++
      }
      hash[h(line.p2)]++
   }

   mut ans := 0
   for _, v in hash {
      ans += u8(v > 1)
   }

   return ans.str()
}

