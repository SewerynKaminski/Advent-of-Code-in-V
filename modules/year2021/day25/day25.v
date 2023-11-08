module day25

import os
import term

const path = 'modules/year2021/day25/input'
const pathtest = 'modules/year2021/day25/testinput'

//---------------------------------------------------------------------------//
fn load ( ) ![][]u8 {
   input_path := path
   //input_path = pathtest

   lines := os.read_lines( input_path )!
   mut data := [][]u8{};

   for line in lines {
	data << line.bytes()
   }
   return data
}

fn show( d [][]u8 ) {
	for i in 0..d.len {
	   println( d[i].bytestr() )
	}  println( '' )
}

fn step_east_facing ( mut data [][]u8 ) u64 {
	mut cnt := u64(0)
	w := data[0].len
	h := data.len

	for i in 0..h {
	   t:= data[i][w-1]
	   tt:=	data[i][0]
	   for j:=0; j<w-1; j+=1 {
	      if data[i][j] == '>'[0] && data[i][j+1] == '.'[0] {
		 data[i][j]  = '.'[0]
		 data[i][j+1]= '>'[0]
		 cnt+=1
		 j+=1
	      }
	   }
	   if t=='>'[0] && tt=='.'[0] {
		 data[i][w-1]= '.'[0]
		 data[i][0]  = '>'[0]
		 cnt+=1
	   }
	}
	return cnt
}

fn step_south_facing ( mut data [][]u8 ) u64 {
	mut cnt := u64(0)
	w := data[0].len
	h := data.len

	for i in 0..w {
	   t:= data[h-1][i]
	   tt:=	data[0][i]
	   for j:=0; j<h-1; j+=1 {	      
              if data[j][i] == 'v'[0] && data[j+1][i]=='.'[0] {
		 data[j][i]  = '.'[0]
		 data[j+1][i]= 'v'[0]
		 cnt+=1
		 j+=1
	      }
	   }
	   if t=='v'[0] && tt=='.'[0] {
		 data[h-1][i]= '.'[0]
		 data[0][i]  = 'v'[0]
		 cnt+=1
	   }
	}
	return cnt
}

fn step ( mut data [][]u8 ) u64 {
	return step_east_facing ( mut data ) + step_south_facing ( mut data )
}

//---------------------------------------------------------------------------//
pub fn task1() string {
	mut data := load() or { return term.bright_red("[Error]Load:" + err.str()) }

	mut ans:= u64(0)
	for step ( mut data ) > 0 {
	   ans += 1
	   //println( "After $ans steps:" )
	   //show ( data )
	}
	ans += 1

	return ans.str()
}

//---------------------------------------------------------------------------//
pub fn task2() string { 
        return "?"
}

//---------------------------------------------------------------------------//
/*

*/



