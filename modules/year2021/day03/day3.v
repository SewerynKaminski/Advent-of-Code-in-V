module day03

import os
import strconv

const path = 'modules/year2021/day03/input'

fn to_i64( s string ) i64 {
	return strconv.parse_int ( s, 10, 64 ) or {0}
}

pub fn task1() string {
    mut data :=[]i32{}
    mut line := []u8{len:16}

    //aoc.test_enable()
    //file := if aoc.is_test_enabled() { test_input() } else { puzzle_input }
    
    mut file := os.open_file ( path, 'r' ) or {
	println("error1 opening 'input' file")
	return "[Error]open"
    }
    mut l := file.read_bytes_into_newline( mut line ) or {0}-1

    mut cnt := i32(0)
    for l>0 {
	for data.len < l {
        	data << 0
	}
        for i := u64(0); i < l; i++  {
            data[i]+= line[i]-48
        }
        cnt += 1
	l = file.read_bytes_into_newline( mut line ) or {0}-1
    }
    mut ans := u32(0)
    for i:=u32(0); i<data.len; i++ {
	ones := data[i]
        zeros := cnt - ones
	ans = (ans << 1) | u8(ones > zeros)
    }
    ans = ans * ( ~ans & 0xfff )

    return ans.str()
}

fn count_ones ( d [][]u8, i u64 ) u64 {
    mut ret := u64(0);
    for s in d {
        if s.len>0 && s[i] == 49 {
            ret += 1
        }
    }

    return ret
}

fn generator_rating ( data [][]u8, o2 bool ) u64 {
    mut dta := data.clone()
    mut len := u64(dta.len)
    for i := 0; len>1 ; i++ {
        ones := count_ones ( dta, i )
        b := 48 + u8( ones >= len - ones ) ^ u8(o2)

        for mut s in dta {
            if s.len>0 && s[i]==b {
            	s.clear()
                len--
            }
        }
    }

    for s in dta {
        if s.len > 0 {
            return strconv.parse_uint ( s.bytestr(), 2, 0 ) or {0}
        }
    }

    return 0
}

pub fn task2() string { 
    mut data := [][]u8{}
    mut line := []u8{len:16}
    mut ans  := u64(0)

    //aoc.test_enable()
    //file := if aoc.is_test_enabled() { test_input() } else { puzzle_input }
    mut file := os.open_file ( path, 'r' ) or {
	println("error2 opening 'input' file")
	return "[Error]open"
    }

    mut l := file.read_bytes_into_newline ( mut line ) or { print("${err}") exit(0)}-1
    for l > 0 {
        data << line[0..l].clone()
        l = file.read_bytes_into_newline ( mut line ) or {0}-1
    }

    o2_generator_rating := generator_rating ( data, true )
    co2_generator_rating := generator_rating ( data, false )

    ans = o2_generator_rating * co2_generator_rating

    return ans.str()
}


