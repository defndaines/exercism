export class HighScores {
  constructor(arr) {
    this.scores = arr;
  }

  get highest() { return Math.max(...this.scores); }

  get latest() { return this.scores[this.scores.length - 1]; }

  get report() {
    const fromBest = this.highest - this.latest;
    return [
      `Your latest score was ${this.latest}.`,
      fromBest === 0
        ? "That's your personal best!"
        : `That's ${fromBest} short of your personal best!`,
    ].join(' ');
  }

  get top() { return [...this.scores].sort((x, y) => y - x).slice(0, 3); }
}
