export default class Isogram {
  constructor(word) {
    this.word = word.toLocaleLowerCase().replace(/[^a-z]/g, '');
  }

  isIsogram() {
    return this.word.length === (new Set([...this.word])).size;
  }
}
