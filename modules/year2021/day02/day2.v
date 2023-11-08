module day02

import os
import term
import strconv

const path = 'modules/year2021/day02/input'

fn to_i64( s string ) i64 {
	return strconv.parse_int ( s, 10, 64 ) or {0}
}

pub fn task1() string {
    mut ans := i64(0)
    mut depth := i64(0)
    mut line := []u8{len:128}

    //aoc.test_enable();
    //file := aoc.is_test_enabled() ? test_input() : puzzle_input;
    mut file := os.open_file ( path, 'r' ) or {return term.bright_red("[Error]open:"+err.str())}
    mut l := file.read_bytes_into_newline( mut line ) or {0}-1
    for l>0 {	
        s := line[0..l].bytestr().trim('\n' )
        l = s.len
        match s[0] {
	        'd'[0]{ depth += to_i64 ( s[5..l] ) }
	        'u'[0]{ depth -= to_i64 ( s[3..l] ) }
	        'f'[0]{ ans += to_i64 ( s[8..l] ) }
		else{}
        }
	l = file.read_bytes_into_newline( mut line ) or {0}-1
    }
    ans *= depth

    return ans.str()
}

pub fn task2() string { 
    mut ans   := i64(0)
    mut depth := i64(0)
    mut aim   := i64(0)
    mut line  := []u8{len:128}

    //aoc::test_enable();
    //auto& file = aoc::is_test_enabled() ? test_input() : puzzle_input;
    mut file := os.open_file ( path, 'r' ) or {	return term.bright_red("[Error]open:"+err.str()) }

    mut l := file.read_bytes_into_newline( mut line ) or {0}-1
    for l>0 {
        s := line[0..l].bytestr().trim('\n' )
        l = s.len
        match s[0] {
	        'd'[0]{ aim += to_i64 ( s[5..] ) }
        	'u'[0]{ aim -= to_i64 ( s[3..] ) }
        	'f'[0]{ x := to_i64 ( s[8..] )
        	    ans += x
        	    depth += aim * x
        	}
		else{}
        }
	l = file.read_bytes_into_newline( mut line ) or {0}-1
    }
    ans *= depth

    return ans.str ( )
}

