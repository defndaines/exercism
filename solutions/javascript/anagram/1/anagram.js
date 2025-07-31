const normalize = word => [...word.toLocaleLowerCase()].sort().join('');

export default class Anagram {
  constructor(word) {
    this.word = word.toLocaleLowerCase();
    this.normalized = normalize(word);
  }

  matches(arr) {
    return arr.filter(word => normalize(word) === this.normalized
      && word.toLocaleLowerCase() !== this.word);
  }
}
