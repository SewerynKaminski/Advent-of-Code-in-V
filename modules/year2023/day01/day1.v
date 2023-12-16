module day01

import aoc
import term
import arrays
import math 

const path = 'modules/year2023/day01/input'

fn is_digit ( c u8 ) bool { return c>=48 && c<=48+9 }

fn first_digit ( line []u8 ) ?u8 {	
	return arrays.find_first ( line, is_digit )
}

fn last_digit ( line []u8 ) ?u8 {
	return arrays.find_last( line, is_digit )
}

fn load() ![][]u8 {
    mut ret := [][]u8{}
    lines:= aoc.read_lines ( path )!
    for line in lines {
	ret << line.bytes()
    }
    return ret
}

pub fn task1() string {
    mut ans := i64(0)

    lines := load() or { return term.bright_red("[Error]Load:"+err.str()) }
    for line in lines {
	mut a := first_digit ( line ) or {48} - 48
	mut b := last_digit ( line ) or {48} - 48
	ans += i64 ( 10 * a + b )
    }
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
    lines := load() or { return term.bright_red("[Error]Load:"+err.str()) }

    for line in lines {
        a := first_name ( line ) or {0}
        b := last_name ( line ) or {0}
        ans += 10 * a + b
    }
    return ans.str()
}

