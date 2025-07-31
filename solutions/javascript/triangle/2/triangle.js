export default class Triangle {
  constructor(a, b, c) {
    [this.a, this.b, this.c] = [a, b, c].sort((x, y) => x - y);
  }

  kind() {
    if (this.a <= 0) {
      throw new Error('sides must be positive integers.');
    } else if (this.a === this.b && this.b === this.c) {
      return 'equilateral';
    } else if (this.b === this.c) {
      return 'isosceles';
    } else if (this.c < this.a + this.b) {
      return 'scalene';
    }
    throw new Error('violation of triangle inequality.');
  }
}
