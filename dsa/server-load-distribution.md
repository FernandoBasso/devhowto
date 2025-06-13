---
description: Explanation on how to approach and implement the server load distribution coding challenge.
---

# Server Load Distribution

Given two arrays `serverCapacity` and `serverLoad`, each of size `n`, which represent the resource capacities of servers and their current workloads respectively, optimize the distribution of the workload.

The total resource consumption is calculated as the sum of `serverCapacity[i] * serverLoad[i]` for all i where 0 ≤ i < n.

Rearrange the `serverLoad` array to minimize the total resource consumption. If multiple arrangements yield the same minimum consumption, return the lexicographically smallest arrangement of `serverLoad`.

## Example

```
serverCapacity = [4, 5, 6]
serverLoad = [1, 2, 3]
```

The task is to rearrange the elements in the array `serverLoad` to minimize the sum, `serverCapacity[i] * serverLoad[i]`.

If `serverLoad = [3, 2, 1]`, the total resources are calculated as follows:

```
43 + 52 + 6 * 1 = 28
```

This arrangement yields the lowest sum of resources.

## Function Description

Complete the function `getRedistributedLoad(serverCapacity, serverLoad)` in the editor with the following parameters:

`int serverCapacity[n]`: the resource requirements of each server.

`int serverLoad[n]`: the distribution of workload across individual servers.

Returns:

`int[n]`: the rearranged array `serverLoad` that minimizes the total resource requirements.

## Go v1

```go
package main

import (
	"fmt"
	"slices"
	"sort"
)

type ServerWithIdx struct {
	Idx int
	Cap int
}

func sortByCapAsc(srv1, srv2 ServerWithIdx) int {
	return srv1.Cap - srv2.Cap
}

func dist(capacities []int, loads []int) []int {
	n := len(capacities)
	capacitiesAsc := capacities[:]
	loadsDesc := loads[:]

	serverCapacitiesAscWithIdx := make([]ServerWithIdx, n)
	for i := range n {
		serverCapacitiesAscWithIdx[i] = ServerWithIdx{
			Idx: i,
			Cap: capacitiesAsc[i],
		}
	}

	// ASC
	slices.SortFunc(serverCapacitiesAscWithIdx, sortByCapAsc)
	fmt.Printf("%#v\n", capacitiesAsc)

	// DESC
	sort.Sort(sort.Reverse(sort.IntSlice(loadsDesc)))

	optimizedServerLoad := make([]int, n)

	for i := range n {
		optimizedServerLoad[serverCapacitiesAscWithIdx[i].Idx] = loadsDesc[i]
	}

	return optimizedServerLoad
}

func main() {
	capacities := []int{4, 5, 6}
	loads := []int{1, 2, 3}

	res := dist(capacities, loads)
	fmt.Printf("%#v\n", res)
}
```
