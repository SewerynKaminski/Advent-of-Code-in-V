module day12

import os
import term

//---------------------------------------------------------------------------//
const path = 'modules/year2021/day12/input'

//---------------------------------------------------------------------------//
fn load ( ) ![]string {
    mut file := os.open_file ( path, 'r' )!
    mut data := []string{}
    mut buf:=[]u8{len:1024}

    mut l:= file.read_bytes_into_newline( mut buf )!-1
    for l>0 {
        data << buf[0..l].bytestr()
	l = file.read_bytes_into_newline( mut buf )!-1
    }

    return data
}

//---------------------------------------------------------------------------//
fn find_nodes ( tree []string, node string ) []string {
    mut data:= []string{}
    for s in tree {
        t:=s.split('-')
        if node == t[0] {
            data << t[1]
        } else if node == t[1] {
            data << t[0]
        }
    }
    return data
}

//---------------------------------------------------------------------------//
fn has_visited ( visited map[string]int, node string ) bool {
    if node[0].is_capital() { return false}
    return visited[node]>0
}

//---------------------------------------------------------------------------//
fn has_visited2 ( visited map[string]int, node string ) bool {
    if node[0].is_capital() { return false } // duze litery odwiedzamy ile chcemy razy
    mut cnt_twice := false
    for _,v in visited {
        if v == 2 { cnt_twice = true break }
    }

    if node == "start" && visited[node] == 1 { return true }
    return visited[node]>0 && cnt_twice
}

//---------------------------------------------------------------------------//
fn traverse ( tree []string, visited map[string]int, node string,
              has_visitedf fn( visited map[string]int, node string) bool ) u64 {
    if node == "end" { return u64(1)}
    if has_visitedf ( visited, node ) { return u64(0)}
    mut sum := u64(0)
    mut vis := visited.clone()
    if !node[0].is_capital() { 
    	vis[node] += 1
    }
    children := find_nodes ( tree, node )
    for child in children {
        sum += traverse ( tree, vis, child, has_visitedf )
    }
    return sum
}

//---------------------------------------------------------------------------//
pub fn task1() string {
   data := load() or { return term.bright_red("[Error]Load:"+err.str()) }
   mut visited := map[string]int{}
   ans := traverse ( data, visited, "start", has_visited )

   return ans.str()
}

//---------------------------------------------------------------------------//
pub fn task2() string { 
   data := load ( ) or { return term.bright_red("[Error]Load:"+err.str()) }

   visited := map[string]int{}
   ans := traverse ( data, visited, "start", has_visited2 );

   return ans.str()
}

//---------------------------------------------------------------------------//
