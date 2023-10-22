module day09

import os

const path = 'modules/year2021/day09/input'

fn load( path string ) ![][]u8 {
   mut file := os.open_file ( path, 'r' )!

   mut data := [][]u8{};
    /* "2199943210\n"
       "3987894921\n"
       "9856789892\n"
       "8767896789\n"
       "9899965678\n"*/
   mut buf :=[]u8{len:128}

   mut l := file.read_bytes_into_newline( mut buf ) or {0}-1
   for l>0 {
      data << []u8{}
      for c in buf {
         data.last() << ( c - 48 );
      }
      l = file.read_bytes_into_newline( mut buf ) or {0}-1
   }
   return data
}

struct Tri{
   y i32
   x i32
   v i32
}

fn low_points( data [][]u8 ) []Tri {
    mut ret :=[]Tri{}
    max_x := data[0].len-1;
    max_y := data.len-1;
    for y in 0..data.len {
        for x in 0..data[0].len {
            mut a:=false 
	    mut b:=false 
            mut c:=false 
            mut d:=false
            v := data[y][x];
            if x < max_x {
                 if v < data[y][x+1] { a=true }
            } else { a=true}
            if x>0 {
                if v < data[y][x-1] { b=true }
            } else { b=true}
            if y < max_y {
                if v < data[y+1][x] { c=true }
            } else { c=true}
            if y > 0 {
                if v < data[y-1][x] { d=true }
            } else { d=true }

            if a && b && c && d {
                ret << Tri{y,x,v}
            }
        }
    }
    return ret
}

pub fn task1() string {
   mut ans := 0

   data := load ( path )or { return "[Error]Load"}

   lp := low_points( data )
   for v in lp {
        ans += v.v + 1;
   }

   return ans.str()
}

fn area( mut data [][]u8, x u32, y u32 ) u64 {
    if y >= data.len ||
       x >= data.len ||
       data[y][x]==9 { return 0}
    data[y][x]=9
    return 1 + area ( mut data, x-1, y )
             + area ( mut data, x+1, y )
             + area ( mut data, x, y+1 )
             + area ( mut data, x, y-1 )
}

pub fn task2() string { 
   mut data := load( path ) or { return "[Error]Load"}

   lp := low_points( data )

	mut areas := []u64{}
   for v in lp {
	   areas << area ( mut data, u32(v.x), u32(v.y) )
   }

   areas.sort ( |a,b| a > b )
   ans := areas[0] * areas[1] * areas[2]

   return ans.str()
}

