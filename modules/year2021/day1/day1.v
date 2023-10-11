module day1

import os
import strconv

const path = 'modules/year2021/day1/input'

fn to_i64( s string ) i64 {
	return strconv.parse_int ( s, 10, 64 ) or {0}
}

pub fn task1() string {
    mut ans := i64(0)
    mut line := []u8{len:128}

    //aoc::test_enable();
    //auto& file = aoc::is_test_enabled() ? test_input() : puzzle_input;
	
    // /home/seweryn/aoc/2021day6/modules/year2021/day1
    mut file := os.open_file ( path, 'r' ) or {
	println("error opening 'input' file")
	return "[Error]open"
    }
    mut l := file.read_bytes_into_newline( mut line ) or {
	print( "${err}")
	return "[Error]read"}-1
    mut v0 := to_i64 ( line[0..l].bytestr().trim('\n') )
    l = file.read_bytes_into_newline( mut line ) or {0}-1
    for l>0 {
        v1 := to_i64 ( line[0..l].bytestr().trim('\n') )
	if v1 > v0 {
        	ans += i64(1)
	}
	v0 = v1
	l = file.read_bytes_into_newline( mut line ) or {0}-1
    }
    file.close( )
    return ans.str()
}

pub fn task2() string { 
    mut ans := i64(0)
    mut line := []u8{len:128}
    mut v1 := i64(0)
    mut v2 := i64(0)
    mut v3 := i64(0)

    //aoc::test_enable();
    //auto& file = aoc::is_test_enabled() ? test_input() : puzzle_input;
    mut file := os.open_file ( path, 'r' ) or {
	println("error opening 'input' file")
	return "[Error]Open"
	}

    mut l := file.read_bytes_into_newline( mut line ) or { return "?"}//getline ( file, line )
    if l>0 {
    	v1 = to_i64 ( line[0..l].bytestr().trim('\n') )
    }
    l = file.read_bytes_into_newline( mut line ) or { return  "?"}
    if l>0 {
	v2 = to_i64 ( line[0..l].bytestr().trim('\n') )
    }
    l = file.read_bytes_into_newline( mut line ) or { return  "?"}
    if l>0 {
	v3 = to_i64 ( line[0..l].bytestr().trim('\n') )
    }
    l = file.read_bytes_into_newline( mut line ) or { return "?"}
    for l>0 {
        v := to_i64 ( line[0..l].bytestr().trim('\n') )
	if v1 < v {
	    ans += i64(1)
	}
        v1 = v2
        v2 = v3
        v3 = v
	l = file.read_bytes_into_newline( mut line ) or { return "?"}
    }

    return ans.str()
}

