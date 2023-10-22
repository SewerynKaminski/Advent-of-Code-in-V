module day14

import os
import term
import arrays

//---------------------------------------------------------------------------//
const path = 'modules/year2021/day14/input'

struct St{
mut:
   t string
   d map[u16]u8
}

//---------------------------------------------------------------------------//
fn load ( ) !St {
    mut data := map[u16]u8{}

    lines:= os.read_lines( path )!
    t:= lines[0]
    for line in lines[2..] {    
       data[ (u16(line[0]) << 8) | line[1] ] = line[6]
    }

    return St{t, data}
}

//---------------------------------------------------------------------------//
pub fn task1() string {
    data := load ( ) or { return term.bright_red("[Error]Load:" + err.str()) }

    mut t := data.t
    mut out := ""
    for _ in 0..10 {
        out = t[0..1]
        for i := 0; i < t.len - 1; i++ {
            a := t[i]
            b := t[i + 1]
            c := data.d[(u16(a) << 8) | b]
            out += [c, b].bytestr()
        }
        t = out.clone()
    }

    mut ma := map[u8]int{}
    for c in out {
        ma[c] += 1
    }

    vals := ma.values()
    ans := arrays.max(vals)or{0} - arrays.min(vals)or{0}
    
    return ans.str()
}

//---------------------------------------------------------------------------//
fn cnt ( mut memo map[u32]map[u8]u64, ma map[u16]u8, a u8, b u8, depth u8 ) map[u8]u64 {
    if depth == 0 { 
        mut ret := map[u8]u64{}
	ret[b] = u64(1)
	return ret
    }
    i := (u32(depth) << 16) | (u32(a) << 8) | u32(b);
    if i in memo { return memo[i] }
    c := ma[(u16(a) << 8) | u16(b)]
    z1 := cnt ( mut memo, ma, a, c, depth - 1 );
    z2 := cnt ( mut memo, ma, c, b, depth - 1 );
    mut z12:= map[u8]u64{}
    for k,v in z1 {
        z12[k] = v
    }
    for k,v in z2 {
        z12[k] += v
    }
    memo[i] = &z12
    return z12
}

//---------------------------------------------------------------------------//
pub fn task2() string {
    //testinput -> 2188189693529
    data := load ( ) or { return term.bright_red("[Error]Load:"+err.str()) }
    
    mut memo:= map[u32]map[u8]u64{}

    mut zz := map[u8]u64{}
    for i:=u32(0); i < data.t.len - 1; i++ {
        for k,v in cnt ( mut memo, data.d, data.t[i], data.t[i + 1], 40 ) {
           zz[k] += v
        }
    }

    vals := zz.values()
    ans := arrays.max(vals)or{0} - arrays.min(vals)or{0}

   return ans.str()
}

