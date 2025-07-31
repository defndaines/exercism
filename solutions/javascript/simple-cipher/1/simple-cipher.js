export class Cipher {
  constructor(key = null) {
    if (key === null) {
      const alphabet = 'abcdefghijklmnopqrstuvwxyz';
      let text = '';
      for (let i = 0; i < 100; i = i + 1) {
        text += alphabet.charAt(Math.floor(Math.random() * alphabet.length));
      }
      this.key = text;
    } else {
      if (/^[a-z]+$/.test(key)) {
        this.key = key;
      } else {
        throw 'Bad key';
      }
    }
  }

  encode(phrase) {
    const A_CHAR = 'a'.charCodeAt(0);
    let encoded = '';
    for (const [i, ch] of [...phrase].entries()) {
      const offset = ((this.key.charCodeAt(i % this.key.length) - A_CHAR) + (ch.charCodeAt(0) - A_CHAR)) % 26;
      encoded += String.fromCharCode(A_CHAR + offset);
    }
    return encoded;
  }

  decode(phrase) {
    const A_CHAR = 'a'.charCodeAt(0);
    let decoded = '';
    for (const [i, ch] of [...phrase].entries()) {
      const offset = ((ch.charCodeAt(0) - A_CHAR) - (this.key.charCodeAt(i % this.key.length) - A_CHAR) + 26) % 26;
      decoded += String.fromCharCode(A_CHAR + offset);
    }
    return decoded;
  }
}
