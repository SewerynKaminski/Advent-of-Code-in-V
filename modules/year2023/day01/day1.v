module day01

import os
import term
//import strconv
import arrays
import math 

const path = 'modules/year2023/day01/input'
//const path = 'modules/year2023/day01/input_test'
//const path = 'modules/year2023/day01/input_test2'

fn is_digit ( c u8 ) bool { return c>=48 && c<=48+9 }

fn first_digit ( line []u8 ) ?u8 {	
	return arrays.find_first ( line, is_digit )
}

fn last_digit ( line []u8 ) ?u8 {
	return arrays.find_last( line, is_digit )
}


fn load() [][]u8 {
    mut ret := [][]u8{}
    mut line := []u8{len:128}
    mut file := os.open_file ( path, 'r' ) or { return ret }
    mut l := file.read_bytes_into_newline( mut line ) or {0}-1
    for l>0 {
	ret << line[0..l].clone()
        l = file.read_bytes_into_newline( mut line ) or {0}-1
    }
    file.close( )
    return ret
}

pub fn task1() string {
    mut ans := i64(0)
    mut line := []u8{len:128}

    //aoc::test_enable();
    //auto& file = aoc::is_test_enabled() ? test_input() : puzzle_input;
	
    // /home/seweryn/aoc/modules/year2023/day1
    mut file := os.open_file ( path, 'r' ) or {	return term.bright_red("[Error]open:"+err.str()) }
    mut l := file.read_bytes_into_newline( mut line ) or {0}-1
    for l>0 {
	mut a := first_digit ( line[0..l] ) or {48} - 48
	mut b := last_digit ( line[0..l] ) or {48} - 48
	ans += i64 ( 10 * a + b )
	l = file.read_bytes_into_newline( mut line ) or {0}-1
    }
    file.close( )
    return ans.str()
}

//const names = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
const namesb = ["zero".bytes(), "one".bytes(), "two".bytes(), "three".bytes(), "four".bytes(), "five".bytes(), "six".bytes(), "seven".bytes(), "eight".bytes(), "nine".bytes()]
fn is_digiti ( i int, c u8 ) bool { return c>=48 && c<=48+9 }

fn first_digit_index ( line []u8 ) ?int {
    return arrays.index_of_first ( line, is_digiti )
}

fn first_name ( line []u8) ?int {
	for i in 0..line.len {
	    if line[i]>48 && line[i]<=48+9 {
	        return line[i]-48
	    }
	    for n in 1..10 {
	       name := namesb[n]//.bytes()
	       max := math.min ( i + name.len, line.len )
	       if line[i..max]==name {
		//print("$line $i $name")
		   return n
	       }
	    }
	}
	return none
}

fn last_name ( line []u8) ?u8 {
	for i:=line.len-1 ; i>=0;i--{
	   if line[i]>=48 && line[i]<=48+9{
	      return line[i]-48
	   }
	   for n in 1..10 {
	      name := namesb[n]//.bytes()
	      max := math.min ( i + name.len, line.len )
              if line[i..max]==name {
		//print("$line.bytestr() $i $name.bytestr()")
		return n
              }
	   }
        }
        return none
}

pub fn task2() string { 
    mut ans := i64(0)
    lines := load()

    for line in lines {
        a := first_name ( line ) or {0}
        b := last_name ( line ) or {0}
	//println("${line.bytestr()} $a$b")
        ans += 10 * a + b
    }
    return ans.str()
}

