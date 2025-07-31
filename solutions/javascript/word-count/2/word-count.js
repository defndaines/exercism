export default class Words {
  count(phrase) {
    const freq = {};
    phrase.toLocaleLowerCase()
      .trim()
      .split(/\s+/)
      .forEach((word) => {
        typeof freq[word] === 'number'
          ? freq[word] += 1
          : freq[word] = 1;
      });
    return freq;
  }
}
