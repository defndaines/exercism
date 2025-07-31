export default class Words {
  count(phrase) {
    const freq = {};
    phrase.toLocaleLowerCase()
      .trim()
      .split(/\s+/)
      .forEach((word) => {
        const count = freq[word] || 0;
        freq[`${word}`] = count + 1;
      });
    return freq;
  }
}
