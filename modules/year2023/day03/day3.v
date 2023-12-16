module day03

import aoc
import term
import arrays

const path = 'modules/year2023/day03/input'

fn load() ![]string {
	mut data := aoc.read_lines ( path )!
	// remove amty line at the end
	for data.last()=='' {
	    data.pop()
	}
	// frame data with '.'
	data.insert(0,".".repeat(data[0].len))
	data << ".".repeat(data[0].len)
	for mut line in data {
	    line = "." + line + "."
	}
	
	return data
}

pub fn task1() string {
	mut ans := i64(0)
	mut data := load ( ) or { return term.bright_red("[Error]Load:"+err.str()) }

	for row in 1..data.len-1 {
	    for col:=1; col < data[row].len-1; col++ {
	        mut numstr:=""
	        mut nr:=0
	        mut nc:=0
	        if data[row][col].is_digit() {
	           nr=row-1
	           nc=col-1
	           for data[row][col].is_digit() {
	           	numstr += data[row][col..col+1]
	           	col++
	           }
	        }
                if numstr.len>0 {
                	mut good := data[nr+1][nc]!='.'[0] || data[nr+1][nc+numstr.len+1]!='.'[0] 
   	                for i in nc..nc+numstr.len+2 {
	        	    if data[nr][i]!='.'[0] || data[nr+2][i]!='.'[0] {
	        	        good=true
	        	        break
	        	    }
	                }
                	
                	if good {
                 	    ans += numstr.i64()
                 	}
                }
	    }
	}
	
	return ans.str()
}

fn getnumber ( line string, arg_i int ) int {
   mut i := arg_i
   for line[i].is_digit() { 
      i++
   }
   mut e := i
   i = arg_i
   for line[i].is_digit() { 
      i--
   }
   mut s := i+1
   return line[s..e].int()
}

fn get_numbers( data []string, row int, col int ) []int {
   mut numbers := []int{}
   mut pattern:=[
   		  int ( data[row][col-1].is_digit() ),
	          int ( data[row][col  ].is_digit() ),
	          int ( data[row][col+1].is_digit() ),
	        ]   
   if pattern==[1,0,1] {
      numbers << getnumber( data[row], col-1 )
      numbers << getnumber( data[row], col+1 )
   } else { 
      ofs := arrays.index_of_first ( pattern, fn ( i int, e int) bool { return e==1 } )
      if ofs >= 0 {
          numbers << getnumber( data[row], col - 1 + ofs )
      }
   }
   return numbers
}

pub fn task2() string {
	mut ans := i64(0)
	data := load() or { return term.bright_red("[Error]Load:"+err.str()) }
	for row in 1..data.len-1 {
	    for col in 1..data[row].len-1 {
	        if data[row][col..col+1] == '*' {
	            mut numbers:=[]int{}
	            numbers << get_numbers ( data, row-1, col )
          	    numbers << get_numbers ( data, row,   col )
	            numbers << get_numbers ( data, row+1, col )
	            
	            if numbers.len == 2 {
	                ans += numbers[0] * numbers[1]	        	
	            }
	        }
	    }
	}
        return ans.str()
}


