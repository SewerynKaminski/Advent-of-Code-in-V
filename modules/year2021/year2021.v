module year2021

import aoc
import year2021.day1
import year2021.day2
import year2021.day3
import year2021.day4
import year2021.day5
import year2021.day6
import year2021.day7
import year2021.day8
import year2021.day9
import year2021.day10
import year2021.day11
import year2021.day12
import year2021.day13
import year2021.day14
import year2021.day15
import year2021.day16
import year2021.day17
import year2021.day18
import year2021.day19
import year2021.day20
import year2021.day21
import year2021.day22
import year2021.day23
import year2021.day24
import year2021.day25

pub const year = 2021

pub const days = aoc.Days{
		day_1 : aoc.Day { day: 1, task_1 :  day1.task1, task_2 :  day1.task2 }
		day_2 : aoc.Day { day: 2, task_1 :  day2.task1, task_2 :  day2.task2 }
		day_3 : aoc.Day { day: 3, task_1 :  day3.task1, task_2 :  day3.task2 }
		day_4 : aoc.Day { day: 4, task_1 :  day4.task1, task_2 :  day4.task2 }
		day_5 : aoc.Day { day: 5, task_1 :  day5.task1, task_2 :  day5.task2 }
		day_6 : aoc.Day { day: 6, task_1 :  day6.task1, task_2 :  day6.task2 }
		day_7 : aoc.Day { day: 7, task_1 :  day7.task1, task_2 :  day7.task2 }
		day_8 : aoc.Day { day: 8, task_1 :  day8.task1, task_2 :  day8.task2 }
		day_9 : aoc.Day { day: 9, task_1 :  day9.task1, task_2 :  day9.task2 }
		day_10: aoc.Day { day:10, task_1 : day10.task1, task_2 : day10.task2 }
		day_11: aoc.Day { day:11, task_1 : day11.task1, task_2 : day11.task2 }
		day_12: aoc.Day { day:12, task_1 : day12.task1, task_2 : day12.task2 }
		day_13: aoc.Day { day:13, task_1 : day13.task1, task_2 : day13.task2 }
		day_14: aoc.Day { day:14, task_1 : day14.task1, task_2 : day14.task2 }
		day_15: aoc.Day { day:15, task_1 : day15.task1, task_2 : day15.task2 }
		day_16: aoc.Day { day:16, task_1 : day16.task1, task_2 : day16.task2 }
		day_17: aoc.Day { day:17, task_1 : day17.task1, task_2 : day17.task2 }
		day_18: aoc.Day { day:18, task_1 : day18.task1, task_2 : day18.task2 }
		day_19: aoc.Day { day:19, task_1 : day19.task1, task_2 : day19.task2 }
		day_20: aoc.Day { day:20, task_1 : day20.task1, task_2 : day20.task2 }
		day_21: aoc.Day { day:21, task_1 : day21.task1, task_2 : day21.task2 }
		day_22: aoc.Day { day:22, task_1 : day22.task1, task_2 : day22.task2 }
		day_23: aoc.Day { day:23, task_1 : day23.task1, task_2 : day23.task2 }
		day_24: aoc.Day { day:24, task_1 : day24.task1, task_2 : day24.task2 }
		day_25: aoc.Day { day:25, task_1 : day25.task1, task_2 : day25.task2 }
}

pub fn run() {
  println( "AoC ${year}" )
  days.run()
}

