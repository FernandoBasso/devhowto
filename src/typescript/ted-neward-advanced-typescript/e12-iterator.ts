import { log } from "./utils";

class Person {
  constructor(public name: string) {}
}

class People implements Iterable<Person> {
  constructor(public population: Array<Person>) {}

  [Symbol.iterator](): Iterator<Person> {
    const localPop = this.population;
    let index = 0;

    const iterator = {
      next() {
        return {
          value: localPop[index++],
          done: index > localPop.length,
        };
      },
    };

    return iterator;
  }
}

const pop = new People([
  new Person("Ahsoka"),
  new Person("Aayla"),
  new Person("Obi-wan"),
  new Person("Luke"),
]);

for (let p of pop) log(p);
// → Person { name: 'Ahsoka' }
// → Person { name: 'Aayla' }
// → Person { name: 'Obi-wan' }
// → Person { name: 'Luke' }
