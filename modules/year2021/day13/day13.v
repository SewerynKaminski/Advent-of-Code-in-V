module day13

//---------------------------------------------------------------------------//
import os

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
    i i32
};

struct St{
   p []Point
   f []Tci
}

//---------------------------------------------------------------------------//
const path = 'modules/year2021/day12/input'

//---------------------------------------------------------------------------//
fn load ( ) !St {
    data := []Point{}
    fold := []Tci{}

    buf []u8{len:1024};
    
    // punkty
    mut l:= file.read_bytes_into_newline( mut buf )!-1    
    while l>0 {
        t:=buf[0..l].bytestr().split(',')
        data << Point{t[0].int(), t[1]int()}
        l = file.read_bytes_into_newline( mut buf )!-1
    }
    // zlozenia
    mut l:= file.read_bytes_into_newline( mut buf )!-1    
    while l>0 {
        c := buf[11]
        v := buf[13..].int()
        fold << Tci{c, v}
        l = file.read_bytes_into_newline( mut buf )!-1
    }

    return St{data, fold}
}

//---------------------------------------------------------------------------//
pub fn task1() string {
    ans := 0
    data, fold := load ( ) or { return "[Error]"+err.str() }

    a, v = fold[0]
    for p in data {
        if a == 'x' {
            if p.x > v {
                p.x = 2 * v - p.x
            }
        } else {
            if p.y > v {
                p.y = 2 * v - p.y
            }
        }
    }

    //set<int> paper
    paper map[int]void
    for x, y in data {
        paper.insert ( ( x << 16 ) | y )
    }
    ans = paper.len

    return ans.str()
}

pub fn task2() string { 
        return "?"
}

