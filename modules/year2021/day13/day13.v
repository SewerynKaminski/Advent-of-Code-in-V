module day13

//---------------------------------------------------------------------------//
import os
import datatypes

//---------------------------------------------------------------------------//
const path = 'modules/year2021/day13/input'

//---------------------------------------------------------------------------//
struct Point {
mut:
    x int
    y int
};

//---------------------------------------------------------------------------//
struct Tci {
mut:
    c u8
    v i32
};

//---------------------------------------------------------------------------//
struct St{
   p []Point
   f []Tci
}

//---------------------------------------------------------------------------//
fn load ( ) !St {
    mut data := []Point{}
    mut fold := []Tci{}

    mut buf := []u8{len:1024}
    mut file := os.open_file ( path, 'r' )!
        
    // punkty
    mut l:= file.read_bytes_into_newline( mut buf )!-1    
    for l>0 {
        t:=buf[0..l].bytestr().split(',')
        data << Point{t[0].int(), t[1].int()}
        l = file.read_bytes_into_newline( mut buf )!-1
    }
    // zlozenia
    l = file.read_bytes_into_newline( mut buf )!-1    
    for l>0 {
        c := buf[11]
        v := buf[13..].bytestr().int()
        fold << Tci{c, i32(v)}
        l = file.read_bytes_into_newline( mut buf )!-1
    }

    return St{data, fold}
}

//---------------------------------------------------------------------------//
pub fn task1() string {
    mut data := load ( ) or { return "[Error]"+err.str() }

    a := data.f[0].c
    v := data.f[0].v
    for mut p in data.p {
        if a == 'x'[0] {
            if p.x > v {
                p.x = 2 * v - p.x
            }
            if p.y > v {
                p.y = 2 * v - p.y
            }
        }
    }

    mut paper := datatypes.Set[int]{}
    for p in data.p {
        paper.add( ( p.x << 16 ) | p.y )
    }
    ans := paper.size()

    return ans.str()
}

//---------------------------------------------------------------------------//
pub fn task2() string { 
    mut data := load ( ) or { return "[Error]"+err.str() }

    for f in data.f {
        for mut p in data.p {
            if f.c == 'x'[0] {
                if p.x > f.v {
                    p.x = 2 * f.v - p.x;
                }
            } else {
                if p.y > f.v {
                    p.y = 2 * f.v - p.y;
                }
            }
        }
    }
    mut minx := 0
    mut maxx := 0
    mut miny := 0
    mut maxy := 0
    for p in data.p {
        minx = if minx > p.x { p.x } else { minx }
        maxx = if maxx < p.x { p.x } else { maxx }
        miny = if miny > p.y { p.y } else { miny }
        maxy = if maxy < p.y { p.y } else { maxy }
    }

    mut img := [][]u8{len: maxy + 1, init:[]u8{len: maxx + 1, init: 32 } }
    for p in data.p {
        img[p.y][p.x] = '#'[0]
    }
    mut ans := " \n"
    for y in img {
    	ans += "            " + y.bytestr() + "\n"
    }
    return ans
}

//---------------------------------------------------------------------------//
