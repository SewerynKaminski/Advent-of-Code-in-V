module day10

import os
import arrays

const path = 'modules/year2021/day10/input'

//---------------------------------------------------------------------------//
const open_paren='('[0]
const close_paren=')'[0]
const open_brace='{'[0]
const close_brace='}'[0]
const open_square='['[0]
const close_square=']'[0]
const open_angle='<'[0]
const close_angle='>'[0]
const test_input =
	"[({(<(())[]>[[{[]{<()<>>\n"+
	"[(()[<>])]({[<{<<[]>>(\n"+
	"{([(<{}[<>[]}>{[]{[(<()>\n"+
	"(((({<>}<{<{<>}{[]{[]{}\n"+
	"[[<[([]))<([[{}[[()]]]\n"+
	"[{[{({}]{}}([{[{{{}}([]\n"+
	"{<[[]]>}<{[{[{[]{()[[[]\n"+
	"[<(<(<(<{}))><([]([]()\n"+
	"<{([([[(<>()){}]>(<<{{\n"+
	"<{([{{}}[<[[[<>{}]]]>[]]"

//---------------------------------------------------------------------------//
fn load( ) ![][]u8 {
   mut file := os.open_file ( path, 'r' )!

   mut data := [][]u8{};
   mut buf :=[]u8{len:128}

   mut l := file.read_bytes_into_newline( mut buf ) or {0}-1
   for l>0 {
      data << buf[0..l].clone()
      l = file.read_bytes_into_newline( mut buf ) or {0}-1
   }
   return data
}

//---------------------------------------------------------------------------//
fn load_test() [][]u8 {
   mut data := [][]u8{}
   t := test_input.split('\n')
   for l in t {
      data << l.bytes()
   }
   return data
}

//---------------------------------------------------------------------------//
fn isopen ( c u8 ) bool {
    return c == open_paren || c == open_brace || c == open_square || c == open_angle
}

//---------------------------------------------------------------------------//
fn isclose ( c u8 ) bool {
    return c == close_paren || c == close_brace || c == close_square || c == close_angle
}

//---------------------------------------------------------------------------//
fn check ( s []u8, i &i32) i32 {
    if *i >= s.len { return -1}
    for *i < s.len {
        match s[*i] {
		open_paren {
		    unsafe{*i+=1}
		    r:= check ( s, i );
		    if r == 0 && isclose ( s[*i] ) {
		        if s[*i] == close_paren {
		            unsafe{*i+=1}
		            return check ( s, i )
		        }
		        return s[*i]
		    }
		    return r
		}
		open_square {
		    unsafe{*i+=1}
		    r:= check ( s, i );
		    if r == 0 && isclose ( s[*i] ) {
		        if s[*i] == close_square {
		            unsafe{*i+=1}
		            return check ( s, i )
		        }
		        return s[*i]
		    }
		    return r
		}
		open_brace {
		    unsafe{*i+=1}
		    r:= check ( s, i )
		    if r == 0 && isclose ( s[*i] ) {
		        if s[*i] == close_brace {
		            unsafe{*i+=1}
		            return check ( s, i )
		        }
		        return s[*i]
		    }
		    return r
		}
		open_angle {
		    unsafe{*i+=1}
		    r:= check ( s, i )
		    if r == 0 && isclose ( s[*i] ) {
		        if s[*i] == close_angle {
		            unsafe{*i+=1}
		            return check ( s, i )
		        }
		        return s[*i]
		    }
		    return r
		}
		else{
		    return 0
		}
        }
    }
    return 0
}

//---------------------------------------------------------------------------//
pub fn task1() string {
    mut ans := 0

    data := load ( ) or { return "[Error]Load"}
    //data := load_test()

    for l in data {
	mut i := i32(0)
        result := check ( l, &i )

        ans += 3 * i32( close_paren == result ) +
               57 * i32( close_square == result ) +
               1197 * i32( close_brace == result ) +
               25137 * i32( close_angle == result )
    }

    return ans.str()
}

//---------------------------------------------------------------------------//
pub fn task2() string { 
   mut scores := []u64{}

   //mut data := load () or { return "[Error]Load"}
   mut data := load_test ()

   for mut l in data {
      mut i := i32(0)
      if -1 == check ( l, &i ) {
         for j := 0; j < 2 * l.len; j++ {
            for k := 0; k < l.len-1; k++ {
               if ( l[k] == open_paren  && l[k + 1] == close_paren ) ||
                  ( l[k] == open_brace  && l[k + 1] == close_brace ) ||
                  ( l[k] == open_square && l[k + 1] == close_square ) ||
                  ( l[k] == open_angle  && l[k + 1] == close_angle ) {
                    //l.replace ( k, 2, "" )
		    l = arrays.append ( l[0..k], l[k+2..] )
               }
            }
         }
           mut score := u64(0)
           for c in l {
                score = score * 5
                        + 1 * u64( c == open_paren )
                        + 2 * u64( c == open_square )
                        + 3 * u64( c == open_brace )
                        + 4 * u64( c == open_angle )
            }
            scores << score
        }
   }

   scores.sort()
   ans := scores[ scores.len / 2 ]

   return ans.str()
}

//---------------------------------------------------------------------------//
