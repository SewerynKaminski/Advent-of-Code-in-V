module day04

import os

//---------------------------------------------------------------------------//
const path = 'modules/year2021/day04/input'

//---------------------------------------------------------------------------//
// Play bingo on all boards
fn play ( numbers []i32, mut boards []BingoBoard ) []BingoBoard {
   mut ret := []BingoBoard{}
   for n in numbers {
      for mut board in boards {
         board.mark ( n )
         if board.wins() {
            board.set_enabled ( false )
            ret << board
         }
      }
   }
   return ret
}

//---------------------------------------------------------------------------//
// Read numbers data form file
fn parse_numbers ( file os.File ) []i32 {
    mut numbers := []i32{}
    mut buf := []u8{len:1024}
    mut l := file.read_bytes_into_newline( mut buf ) or {print(err)}-1
    if l>0 {
	    mut i_s:= 0
	    mut i_e:= buf.index ( 44 )
	    mut len:= i_e - i_s
	    for len > 0 {
		numbers << i32(buf[i_s..i_e].bytestr().int())
		i_s = i_e + 1
		len = buf[i_s..].index ( 44 )
		i_e = i_s + len
	    }
	    numbers << i32(buf[i_s..].bytestr().int())
    }
    return numbers
}

//---------------------------------------------------------------------------//
// Read boards data form file
fn parse_boards ( file os.File ) []BingoBoard {
    mut buf := []u8{len:64}
    mut boards := []BingoBoard{}

    mut l:=1
    for l>0 {
    	l= file.read_bytes_into_newline( mut buf ) or {print(err) exit(0)}	
        if l == 1 {
		mut s :=''
                for i:= 0; i < 5; i++ {
		    l = file.read_bytes_into_newline( mut buf ) or {0}-1
                    s += buf[0..l].bytestr() + " "
                }
                //println( s )
                mut board := BingoBoard{}
                board.set_board_from ( s )
                boards << board
        }
    }
    return boards
}

//---------------------------------------------------------------------------//
pub fn task1() string {
    //aoc::test_enable();
    //auto& file = aoc::is_test_enabled() ? test_input() : puzzle_input;
    mut file := os.open_file ( path, 'r' ) or {return "[Error]open"} 

    numbers := parse_numbers ( file )
    mut boards := parse_boards ( file )
    win := play ( numbers, mut boards )
    // first winning board
    return win.first().score().str()
}

pub fn task2() string { 
   //auto& file = aoc::is_test_enabled() ? test_input() : puzzle_input;
   mut file := os.open_file ( path, 'r' ) or {return "[Error]open"} 

   numbers := parse_numbers ( file )
   mut boards := parse_boards ( file )
   win := play ( numbers, mut boards )
   // last winning board
   return win.last().score().str()
}

