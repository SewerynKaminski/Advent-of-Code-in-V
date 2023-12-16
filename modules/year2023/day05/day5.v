module day05

import aoc
import term
import arrays
import math

const path='modules/year2023/day05/input'
	   //'modules/year2023/day05/input_test'

struct Range {
mut:
   s i64
   e i64
}

struct MAP{
   dr Range
   sr Range
   d i64
}

struct DATA {
mut:
   seeds []i64
   seed2soil []MAP
   soil2fertilizer []MAP
   fertilizer2water []MAP
   water2light []MAP
   light2temperature []MAP
   temperature2humidity []MAP
   humidity2location []MAP
}

fn (d DATA) seed_to_soil ( v i64 ) i64 {
   for m in d.seed2soil {
      if m.sr.s <= v && v < m.sr.e {
         return m.d + v
      }
   }
   return v
}

fn (d DATA) check ( arr []MAP, r Range ) []Range {
   mut ret:=[]Range{}
   mut ra:=[r]
   for m in arr {
      if ra.len==0 {break}
      mut rb := []Range{}
      for rr in ra {
	      if m.sr.s <= rr.s && rr.s <= m.sr.e &&
		 m.sr.s < rr.e && rr.e <= m.sr.e {
		 ret << Range {s: m.d + rr.s, e: m.d + rr.e }
	      } else if m.sr.s <= rr.s && rr.s <= m.sr.e {
		 ret << Range {s : m.d + rr.s, e : m.d + m.sr.e }
		 if m.sr.e < rr.e {rb << Range{s: m.sr.e, e: rr.e}}
	      } else if m.sr.s < rr.e && rr.e <= m.sr.e {
		 if m.sr.s < rr.e { ret << Range { s: m.d + m.sr.s, e: m.d + rr.e} }
		 if rr.s < m.sr.s { rb << Range{s: rr.s, e: m.sr.s} }
	      } else if rr.s < m.sr.s && rr.e > m.sr.e {
		 ret << Range{ s: m.dr.s, e: m.dr.e}
		 rb << Range{s: rr.s, e: m.sr.s}
		 rb << Range{s: m.sr.e, e: rr.e}
	      } else {
		 rb << rr
	      }
      }
      ra = rb.clone()
   }
   if ra.len > 0 {
      ret << ra
   }
   return ret
}

fn (d DATA) soil_to_fertilizer ( v i64 ) i64 {
   for m in d.soil2fertilizer {
      if m.sr.s <= v && m.sr.e > v {
         return m.d + v
      }
   }
   return v
}

fn (d DATA) fertilizer_to_water ( v i64 ) i64 {
   for m in d.fertilizer2water {
      if m.sr.s <= v && m.sr.e > v {
         return m.d + v
      }
   }
   return v
}

fn (d DATA) water_to_light ( v i64 ) i64 {
   for m in d.water2light {
      if m.sr.s <= v && m.sr.e > v {
         return m.d + v
      }
   }
   return v
}

fn (d DATA) light_to_temperature ( v i64 ) i64 {
   for m in d.light2temperature {
      if m.sr.s <= v && m.sr.e > v {
         return m.d + v
      }
   }
   return v
}

fn (d DATA) temperature_to_humidity ( v i64 ) i64 {
   for m in d.temperature2humidity {
      if m.sr.s <= v && m.sr.e > v {
         return m.d + v
      }
   }
   return v
}

fn (d DATA) humidity_to_location ( v i64 ) i64 {
   for m in d.humidity2location {
      if m.sr.s <= v && m.sr.e > v {
         return m.d + v
      }
   }
   return v
}

fn readmap ( mut lines []string ) []MAP {
   mut m := []MAP{}
   lines.pop()
   for lines.len > 0 {
      mut line:= lines.pop()
      if line.len == 0 { break }
      v := line.split ( ' ' )
      m << MAP {
                 dr : Range { s: v[0].i64(), e: v[0].i64()+v[2].i64()},
                 sr : Range { s: v[1].i64(), e: v[1].i64()+v[2].i64()},
                 d  : v[0].i64()-v[1].i64()
               }      
   }
   return m
}

fn load ( ) !DATA {
   mut data := DATA {}
   mut lines := aoc.read_lines( path )!
   lines.reverse_in_place()
   line := lines.pop()
   s := line.split ( ': ' )
   seeds := s[1].split( ' ' )
   data.seeds = seeds.map( it.i64() )
   lines.pop()
   data.seed2soil = readmap ( mut lines )
   data.soil2fertilizer = readmap ( mut lines )
   data.fertilizer2water = readmap ( mut lines )
   data.water2light = readmap ( mut lines )
   data.light2temperature = readmap ( mut lines )
   data.temperature2humidity = readmap ( mut lines )
   data.humidity2location = readmap ( mut lines )
   
   return data
}

pub fn task1() string {
   mut ans := i64( math.max_i64 )
   mut data := load() or { return term.bright_red("[Error]open:"+err.str()) }

   for seed in data.seeds {
      soil       := data.seed_to_soil ( seed )
      fertilizer := data.soil_to_fertilizer ( soil )
      water      := data.fertilizer_to_water ( fertilizer )
      light      := data.water_to_light ( water )
      temperature:= data.light_to_temperature ( light )
      humidity   := data.temperature_to_humidity ( temperature )
      location   := data.humidity_to_location ( humidity )
      ans         = math.min ( ans, location )
   }

   return ans.str()
}

pub fn task2() string { 
   mut ans := i64( math.max_i64 )
   mut data := load() or { return term.bright_red("[Error]open:"+err.str()) }

   seeds := arrays.chunk ( data.seeds, 2 )
   for sa in seeds {
      seed := Range{s:sa[0], e:sa[0]+sa[1]}
      soils       := data.check ( data.seed2soil, seed )
      mut fertilizers  := []Range{}
      for soil       in soils         { fertilizers << data.check ( data.soil2fertilizer, soil ) }
      mut waters       := []Range{}
      for fertilizer in fertilizers   { waters      << data.check ( data.fertilizer2water, fertilizer ) }
      mut lights       := []Range{}
      for water      in waters        { lights      << data.check ( data.water2light, water ) }
      mut temperatures := []Range{}
      for light in lights             { temperatures << data.check ( data.light2temperature, light ) }
      mut humiditys    := []Range{}
      for temperature in temperatures { humiditys   << data.check ( data.temperature2humidity, temperature ) }
      mut locations    := []Range{}
      for humidity in humiditys { locations   << data.check ( data.humidity2location, humidity ) }
      loc := locations.map( it.s )
      ans = math.min( ans, arrays.min( loc ) or { 0 } )
   }
     
   return ans.str()
}
