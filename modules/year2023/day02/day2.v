module day02

import os
import arrays
import term

const path = 
	'modules/year2023/day02/input'
	//'modules/year2023/day02/input_test'

struct RGB{
mut:
    r int
    g int
    b int
}

fn (rgb RGB) power() i64 {
    return rgb.r * rgb.g * rgb.b
}

fn load() ![][]RGB{
   lines := os.read_lines( path )!
   mut games := [][]RGB{}
   for line in lines {
      games << []RGB{}
      game_sets := line.split(':')[1].split(';')
      for set in game_sets {
	 //' 3 red, 7 green, 8 blue'
	 cubes := set.split(',')
	 mut r:=0
	 mut g:=0
	 mut b:=0
	 for color in cubes {
	    match color[color.len-1..] {
	       'd'  { r = color[1..].int() }
	       'n'  { g = color[1..].int() }
	       'e'  { b = color[1..].int() }
	       else { }
	    }
	 }
         games.last() << RGB{r,g,b}
      }
   }
   return games
}

pub fn task1() string {
    mut ans := i64(0)
    data := load ( ) or { return term.bright_red("[Error]Load:"+err.str()) }
    for i,game in data {
    	max := RGB{12, 13, 14}
    	mut good := true
    	for set in game {
    	    //print ( set )
    	    good = good && set.r <= max.r && set.g <= max.g && set.b <= max.b
    	    if !good { break }
    	}
    	if good {
    	    ans += i + 1
    	}
    }
    return ans.str()
}

pub fn task2() string { 
   mut ans := i64(0)
   data := load ( ) or { return term.bright_red("[Error]Load:"+err.str()) }
   for game in data {
      mut min := RGB{0,0,0}
      for set in game {
	 if set.r > min.r { min.r = set.r }
	 if set.g > min.g { min.g = set.g }
         if set.b > min.b { min.b = set.b }
      }
      ans += min.power()
   }
   return ans.str()
}

