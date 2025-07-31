export class SpaceAge {
  constructor(age) {
    this.seconds = age;
  }

  ageByFactor(n) { return Number((this.seconds / (31557600 * n)).toFixed(2)); }

  onEarth() { return this.ageByFactor(1); }

  onMercury() { return this.ageByFactor(0.2408467); }

  onVenus() { return this.ageByFactor(0.61519726); }

  onMars() { return this.ageByFactor(1.8808158); }

  onJupiter() { return this.ageByFactor(11.862615); }

  onSaturn() { return this.ageByFactor(29.447498); }

  onUranus() { return this.ageByFactor(84.016846); }

  onNeptune() { return this.ageByFactor(164.79132); }
}
