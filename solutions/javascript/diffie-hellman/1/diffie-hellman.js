const isPrime = (n) => {
  Array.from({ length: n / 2 }, (_, i) => i + 2)
    .forEach((x) => {
      if (n % x === 0) {
        throw new Error(`${n} is not prime. Divisible by ${x}.`);
      }
    });
  return n;
};

export default class DiffieHellman {
  constructor(primeOne, primeTwo) {
    this.p = isPrime(primeOne);
    this.g = isPrime(primeTwo);
  }

  getPublicKeyFromPrivateKey(n) {
    if (n < 2 || n >= this.p) {
      throw new Error('Invalid private key.');
    }
    return (this.g ** n) % this.p;
  }

  getSharedSecret(privateKey, publicKey) {
    return (publicKey ** privateKey) % this.p;
  }
}
