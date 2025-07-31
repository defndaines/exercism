const reportLatest = latest => `Your latest score was ${latest}.`;

const reportComparison = (latest, highest) => {
  if (latest === highest) {
    return "That's your personal best!";
  }
  return `That's ${highest - latest} short of your personal best!`;
};

export class HighScores {
  constructor(arr) {
    this.scores = arr;
    this.latest = arr[arr.length - 1];
    this.highest = Math.max(...arr);
    this.top = [...arr].sort((x, y) => y - x).slice(0, 3);
    this.report = [
      reportLatest(this.latest),
      reportComparison(this.latest, this.highest),
    ].join(' ');
  }
}
